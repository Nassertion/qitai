import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/features/client/auth/presentation/helper/auth_required.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/search_widget.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_cars_section.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_categories_section.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_products_sliver.dart';
import 'package:qitai/features/client/home/presentation/widgets/section_header_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/slider_widget.dart';
import 'package:qitai/features/client/products/presentation/provider/all_products_notifier.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';

class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  Future<void> _setDefaultCar(WidgetRef ref, int carId) async {
    try {
      await ref.read(setDefaultUserCarProvider)(carId);

      ref.invalidate(userCarsProvider);
    } catch (_) {}
  }

  void _openAddCar(BuildContext context, WidgetRef ref) {
    requireAuth(
      context: context,
      ref: ref,
      onAuthenticated: () {
        if (!context.mounted) return;
        context.push('/profile/addCar');
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isAuthenticated = authState is Authenticated;
    final userCarsAsync = isAuthenticated ? ref.watch(userCarsProvider) : null;
    final cars = userCarsAsync?.asData?.value ?? [];
    debugPrint('HOME CARS COUNT: ${cars.length}');
    debugPrint('AUTHENTICATED: $isAuthenticated');
    final hasDefaultCar = cars.any((car) => car.isDefault);
    ref.listen(authProvider, (previous, next) {
      if (next is Unauthenticated) {
        ref.read(vehicleProvider.notifier).clearAll();
      }
    });

    if (isAuthenticated) {
      ref.listen(userCarsProvider, (previous, next) {
        next.whenData((cars) {
          final defaultCars = cars.where((car) => car.isDefault);
          final vehicleNotifier = ref.read(vehicleProvider.notifier);
          final vehicleState = ref.read(vehicleProvider);

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

                  HomeCarsSection(
                    isAuthenticated: isAuthenticated,
                    userCarsAsync: userCarsAsync,
                    onAddCar: () => _openAddCar(context, ref),
                    onSelectCar: (car) => _setDefaultCar(ref, car.id),
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

            SliverToBoxAdapter(child: HomeCategoriesSection()),

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

            const HomeProductsSliver(),
          ],
        ),
      ),
    );
  }
}
