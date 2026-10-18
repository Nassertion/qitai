import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';

import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';

import 'package:qitai/features/client/products/presentation/provider/all_products_notifier.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';

import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicles_widget.dart';

class AllProductsScreen extends ConsumerWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authProvider) is Authenticated;

    int? brandId;
    int? modelId;
    int? yearId;

    if (isAuthenticated) {
      final carsAsync = ref.watch(userCarsProvider);

      if (carsAsync.isLoading && !carsAsync.hasValue) {
        return const Scaffold(body: Center(child: CustomLoading()));
      }

      final cars = carsAsync.asData?.value ?? [];

      for (final car in cars) {
        if (car.isDefault) {
          brandId = car.vehicle.brandId;
          modelId = car.vehicle.modelId;
          yearId = car.vehicle.yearId;
          break;
        }
      }
    }

    final scopeKey = '${isAuthenticated}_${brandId}_${modelId}_$yearId';

    return ProviderScope(
      key: ValueKey(scopeKey),
      overrides: [
        vehicleProvider(VehicleScope.browse).overrideWith(VehicleNotifier.new),
        allProductsProvider.overrideWith(AllProductsNotifier.new),
      ],
      child: _AllProductsContent(
        brandId: brandId,
        modelId: modelId,
        yearId: yearId,
      ),
    );
  }
}

class _AllProductsContent extends ConsumerStatefulWidget {
  const _AllProductsContent({
    required this.brandId,
    required this.modelId,
    required this.yearId,
  });

  final int? brandId;
  final int? modelId;
  final int? yearId;

  @override
  ConsumerState<_AllProductsContent> createState() =>
      _AllProductsContentState();
}

class _AllProductsContentState extends ConsumerState<_AllProductsContent> {
  late final ScrollController _scrollController;

  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    Future.microtask(_initializeFilter);
  }

  Future<void> _initializeFilter() async {
    final brandId = widget.brandId;
    final modelId = widget.modelId;
    final yearId = widget.yearId;

    if (brandId != null && modelId != null && yearId != null) {
      await ref
          .read(vehicleProvider(VehicleScope.browse).notifier)
          .selectVehicleByIds(
            brandId: brandId,
            modelId: modelId,
            yearId: yearId,
          );
    }

    if (!mounted) return;

    setState(() {
      _isInitializing = false;
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _isInitializing) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(allProductsProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const Scaffold(body: Center(child: CustomLoading()));
    }

    final state = ref.watch(allProductsProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: 'اقتراحات',
        action: IconButton(
          padding: const EdgeInsets.only(left: 4),
          onPressed: () {
            context.push('/search');
          },
          icon: SvgPicture.asset(
            'assets/icons/search-normal.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: AppPagePadding(
        child: Column(
          children: [
            h12,
            const VehiclesWidget(),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return const Center(child: CustomLoading());
                  }

                  if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  }

                  if (state.products.isEmpty) {
                    return const EmptyDataWidget(
                      text: 'لا توجد منتجات',
                      img: 'assets/icons/Object.svg',
                    );
                  }

                  return GridView.builder(
                    controller: _scrollController,
                    itemCount:
                        state.products.length + (state.isLoadingMore ? 1 : 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 265,
                        ),
                    itemBuilder: (context, index) {
                      if (index >= state.products.length) {
                        return const Center(child: CustomLoading());
                      }

                      final product = state.products[index];

                      return AllProductCardWidget(
                        product: product,
                        onTap: () {
                          context.push('/product/${product.id}');
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
