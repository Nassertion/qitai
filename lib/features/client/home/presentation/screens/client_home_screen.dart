import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/helpers/auth_required.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/search_widget.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';

import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/home/presentation/widgets/add_car_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/section_header_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/slider_widget.dart';
import 'package:qitai/features/client/products/presentation/provider/all_products_notifier.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';

class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  Future<void> _setDefaultCar(WidgetRef ref, int carId) async {
    try {
      await ref.read(setDefaultUserCarProvider)(carId);

      ref.invalidate(userCarsProvider);
    } catch (_) {}
  }

  Widget _buildAddCarItem({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        requireAuth(
          context: context,
          ref: ref,
          onAuthenticated: () {
            context.push('/profile/addCar');
          },
        );
      },
      child: const AddCar(
        img: 'assets/icons/addCar.svg',
        carName: 'اضف سيارتك',
      ),
    );
  }

  Widget _buildCarsSection({
    required BuildContext context,
    required WidgetRef ref,
    required AsyncValue<List<dynamic>> userCarsAsync,
  }) {
    return userCarsAsync.when(
      loading: () =>
          const SizedBox(height: 92, child: Center(child: CustomLoading())),
      error: (error, stack) => Row(
        textDirection: TextDirection.rtl,
        children: [_buildAddCarItem(context: context, ref: ref)],
      ),
      data: (cars) {
        final sortedCars = [
          ...cars,
        ]..sort((a, b) => (b.isDefault ? 1 : 0).compareTo(a.isDefault ? 1 : 0));

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              const SizedBox(width: 14),

              ...sortedCars.map(
                (car) => Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  child: HomeCarItem(
                    car: car,
                    onTap: () => _setDefaultCar(ref, car.id),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: _buildAddCarItem(context: context, ref: ref),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isAuthenticated = authState is Authenticated;

    final categoriesAsync = ref.watch(categoriesProvider);
    final productsState = ref.watch(allProductsProvider);

    final userCarsAsync = isAuthenticated ? ref.watch(userCarsProvider) : null;

    final homeProducts = productsState.products.take(8).toList();

    return Scaffold(
      appBar: HomeAppBarWidget(),
      body: RefreshIndicator(
        backgroundColor: AppColors.inputFieldAndCards,
        color: AppColors.actionText,
        onRefresh: () async {
          ref.invalidate(categoriesProvider);

          final categoriesFuture = ref.read(categoriesProvider.future);

          final productsFuture = ref
              .read(allProductsProvider.notifier)
              .loadProducts();

          if (isAuthenticated) {
            ref.invalidate(userCarsProvider);
          }

          final futures = <Future<dynamic>>[categoriesFuture, productsFuture];

          if (isAuthenticated) {
            futures.add(ref.read(userCarsProvider.future));
          }

          await Future.wait(futures);
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  h8,

                  AppPagePadding(
                    child: SearchWidget(
                      readOnly: true,
                      onTap: () => context.push('/search'),
                    ),
                  ),

                  h16,

                  SectionHeader(
                    title: 'سياراتي',
                    onTap: () {
                      context.push('/profile/cars');
                    },
                  ),

                  h12,

                  if (!isAuthenticated)
                    AppPagePadding(
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildAddCarItem(context: context, ref: ref),
                        ],
                      ),
                    )
                  else
                    _buildCarsSection(
                      context: context,
                      ref: ref,
                      userCarsAsync: userCarsAsync!,
                    ),

                  h16,

                  ClientBannerSlider(),

                  const SizedBox(height: 24),

                  SectionHeader(
                    title: 'الفئات',
                    onTap: () => context.push('/categories'),
                  ),

                  h12,
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 95,
                width: 80,
                child: categoriesAsync.when(
                  loading: () => const CustomLoading(),
                  error: (error, stack) => Center(
                    child: Text(
                      error.toString(),
                      style: AppTextStyles.regularOverline.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  data: (categories) => ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, _) => w12,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return InkWell(
                        onTap: () => context.push(
                          '/categories/${category.id}',
                          extra: category.name,
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              getCategoryIcon(category.name),
                              width: 74,
                              height: 56,
                            ),
                            h8,
                            Text(
                              category.name,
                              style: AppTextStyles.mediumOverline.copyWith(
                                color: AppColors.primaryText,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  h16,

                  SectionHeader(
                    title: 'اقتراحات',
                    onTap: () => context.push('/products'),
                  ),

                  h12,
                ],
              ),
            ),

            if (productsState.isLoading)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: CustomLoading(),
                  ),
                ),
              )
            else if (productsState.errorMessage != null)
              SliverToBoxAdapter(
                child: Center(child: Text(productsState.errorMessage!)),
              )
            else if (homeProducts.isEmpty)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('لا توجد منتجات'),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = homeProducts[index];

                    return AllProductCardWidget(
                      product: product,
                      onTap: () {
                        context.push('/product/${product.id}');
                      },
                    );
                  }, childCount: 4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 260,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// temp only
String getCategoryIcon(String name) {
  switch (name) {
    case 'الفرامل':
      return 'assets/images/breaks.png';
    case 'المحرك':
      return 'assets/images/engine.png';
    case 'الكهرباء':
      return 'assets/images/boaji.png';
    case 'الزيوت والسوائل':
      return 'assets/images/oils.png';
    case 'التعليق':
      return 'assets/images/t3le8.png';
    default:
      return 'assets/images/default.png';
  }
}
