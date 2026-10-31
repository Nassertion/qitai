import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/search_widget.dart';
import 'package:qitai/features/client/auth/presentation/helper/auth_required.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/home/presentation/widgets/add_car_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_car_skeleton.dart';
import 'package:qitai/features/client/home/presentation/widgets/section_header_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/slider_widget.dart';
import 'package:qitai/features/client/products/presentation/provider/all_products_notifier.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_skeleton.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';

class ClientHomeScreen extends ConsumerStatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  ConsumerState<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends ConsumerState<ClientHomeScreen> {
  // # Default Car Request Guard
  bool _isChangingDefaultCar = false;

  // # Set Default Car
  Future<void> _setDefaultCar(int carId) async {
    if (_isChangingDefaultCar) return;

    _isChangingDefaultCar = true;

    try {
      await ref.read(setDefaultUserCarProvider)(carId);

      if (!mounted) return;

      ref.invalidate(userCarsProvider);
    } catch (_) {
      // Preserve existing error-handling behavior.
    } finally {
      _isChangingDefaultCar = false;
    }
  }

  // # Add Car Widget
  Widget _buildAddCarItem() {
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

  // # Cars Section
  Widget _buildCarsSection({required AsyncValue<List<dynamic>> userCarsAsync}) {
    return userCarsAsync.when(
      skipLoadingOnRefresh: false,

      loading: () => HomeCarsSkeleton(count: userCarsAsync.value?.length ?? 3),
      error: (error, stack) =>
          Row(textDirection: TextDirection.rtl, children: [_buildAddCarItem()]),

      data: (cars) {
        final sortedCars = [
          ...cars,
        ]..sort((a, b) => (b.isDefault ? 1 : 0).compareTo(a.isDefault ? 1 : 0));

        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                const SizedBox(width: 14),

                ...sortedCars.map(
                  (car) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12),
                    child: HomeCarItem(
                      car: car,
                      onTap: () => _setDefaultCar(car.id),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  child: _buildAddCarItem(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // # Product Grid Layout
  static const _productGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    mainAxisExtent: 260,
  );

  // # Products Skeleton
  Widget _buildProductsSkeleton() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return const AllProductCardSkeleton();
        }, childCount: 4),
        gridDelegate: _productGridDelegate,
      ),
    );
  }

  // # Build Home Screen
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isAuthenticated = authState is Authenticated;

    final categoriesAsync = ref.watch(categoriesProvider);
    final productsState = ref.watch(allProductsProvider);

    final userCarsAsync = isAuthenticated ? ref.watch(userCarsProvider) : null;

    final cars = userCarsAsync?.asData?.value ?? [];
    final hasDefaultCar = cars.any((car) => car.isDefault);
    final homeProducts = productsState.products.take(8).toList();

    // # Authentication Listener
    ref.listen(authProvider, (previous, next) {
      if (next is Unauthenticated) {
        ref.read(vehicleProvider.notifier).clearAll();
      }
    });

    // # Default Car Synchronization
    if (isAuthenticated) {
      ref.listen(userCarsProvider, (previous, next) {
        next.whenData((cars) {
          final defaultCars = cars.where((car) => car.isDefault);

          final vehicleNotifier = ref.read(vehicleProvider.notifier);

          final vehicleState = ref.read(vehicleProvider);

          // # No Default Car
          if (defaultCars.isEmpty) {
            final hasSelectedVehicle =
                vehicleState.selectedCarBrand != null ||
                vehicleState.selectedModel != null ||
                vehicleState.selectedCarYear != null;

            if (hasSelectedVehicle) {
              vehicleNotifier.clearAll();
            }

            return;
          }

          final defaultCar = defaultCars.first;

          // # Skip Same Vehicle
          final isSameVehicle =
              vehicleState.selectedCarBrand?.id == defaultCar.vehicle.brandId &&
              vehicleState.selectedModel?.id == defaultCar.vehicle.modelId &&
              vehicleState.selectedCarYear?.id == defaultCar.vehicle.yearId;

          if (isSameVehicle) return;

          unawaited(
            vehicleNotifier.selectVehicleByIds(
              brandId: defaultCar.vehicle.brandId,
              modelId: defaultCar.vehicle.modelId,
              yearId: defaultCar.vehicle.yearId,
            ),
          );
        });
      });
    }

    return Scaffold(
      appBar: HomeAppBarWidget(),

      // # Pull To Refresh
      body: RefreshIndicator(
        backgroundColor: AppColors.inputFieldAndCards,
        color: AppColors.actionText,
        onRefresh: () async {
          // # Refresh Categories
          ref.invalidate(categoriesProvider);

          final categoriesFuture = ref.read(categoriesProvider.future);

          // # Refresh Products
          final productsFuture = ref
              .read(allProductsProvider.notifier)
              .loadProducts();

          // # Refresh Cars
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
            // # Search And Cars
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
                      requireAuth(
                        context: context,
                        ref: ref,
                        onAuthenticated: () {
                          context.push('/profile/cars');
                        },
                      );
                    },
                  ),

                  h12,

                  if (!isAuthenticated)
                    AppPagePadding(
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [_buildAddCarItem()],
                      ),
                    )
                  else
                    _buildCarsSection(userCarsAsync: userCarsAsync!),

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

            // # Categories Section
            SliverToBoxAdapter(
              child: SizedBox(
                height: 95,
                width: 80,
                child: categoriesAsync.when(
                  skipLoadingOnRefresh: false,

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

            // # Products Section Header
            SliverToBoxAdapter(
              child: Column(
                children: [
                  h16,

                  SectionHeader(
                    title: hasDefaultCar ? 'مناسب لسيارتي' : 'اقتراحات',
                    onTap: () => context.push('/products'),
                  ),

                  h12,
                ],
              ),
            ),

            // # Products Skeleton Loading
            if (productsState.isLoading)
              _buildProductsSkeleton()
            // # Products Error
            else if (productsState.errorMessage != null)
              SliverToBoxAdapter(
                child: Center(child: Text(productsState.errorMessage!)),
              )
            // # Empty Products
            else if (homeProducts.isEmpty)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('لا توجد منتجات'),
                  ),
                ),
              )
            // # Products Grid
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
                  gridDelegate: _productGridDelegate,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// # Category Icons
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
