import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/categories/data/repository/category_repository.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/home/presentation/widgets/add_car_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/section_header_widget.dart';
import 'package:qitai/core/widgets/search_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/slider_widget.dart';
import 'package:qitai/features/client/products/presentation/provider/all_product_provider.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';

class ClientHomeScreen extends ConsumerStatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  ConsumerState<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends ConsumerState<ClientHomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(allProductsProvider.notifier).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final productsState = ref.watch(allProductsProvider);

    final homeProducts = productsState.products.take(8).toList();

    return Scaffold(
      appBar: HomeAppBarWidget(),
      body: RefreshIndicator(
        backgroundColor: AppColors.inputFieldAndCards,
        color: AppColors.actionText,
        onRefresh: () async {
          ref.invalidate(categoriesProvider);
          await ref.read(categoriesProvider.future);

          await ref.read(allProductsProvider.notifier).loadProducts();
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
                      onTap: () => context.push("/search"),
                    ),
                  ),
                  h16,
                  SectionHeader(
                    title: "سياراتي",
                    onTap: () => context.push("/profile/car"),
                  ),
                  h12,
                  Row(
                    children: [
                      AddCar(
                        img: "assets/icons/addCar.svg",
                        carName: "اضف سيارتك",
                      ),
                    ],
                  ),
                  h16,
                  ClientBannerSlider(),
                  const SizedBox(height: 24),
                  SectionHeader(
                    title: "الفئات",
                    onTap: () => context.push("/categories"),
                  ),
                  h12,
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 95,
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
                    separatorBuilder: (_, __) => w12,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return InkWell(
                        onTap: () => context.push(
                          "/categories/${category.id}",
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
                    title: "اقتراحات",
                    onTap: () => context.push("/products"),
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
                    child: Text("لا توجد منتجات"),
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
                        context.push("/product/${product.id}");
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
