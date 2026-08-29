import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/products/presentation/provider/all_product_provider.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';
import 'package:qitai/features/client/search/presentation/widgets/classification_widget.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_notifier.dart';

class AllProductsScreen extends ConsumerStatefulWidget {
  const AllProductsScreen({super.key});

  @override
  ConsumerState<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends ConsumerState<AllProductsScreen> {
  late final VehicleNotifier _vehicleNotifier;

  @override
  void initState() {
    super.initState();
    _vehicleNotifier = ref.read(vehicleProvider.notifier);
    Future.microtask(() {
      _vehicleNotifier.clearAll();
      ref.read(allProductsProvider.notifier).loadProducts();
    });
  }

  @override
  void dispose() {
    Future(() {
      _vehicleNotifier.clearAll();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(allProductsProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: "اقتراحات",
        action: IconButton(
          padding: const EdgeInsets.only(left: 4),
          onPressed: () {
            context.push("/search");
          },
          icon: SvgPicture.asset(
            "assets/icons/search-normal.svg",
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: AppPagePadding(
        child: Column(
          children: [
            h12,
            const ClassificationWidget(),
            // h4,
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
                      text: "لا توجد منتجات",
                      img: "assets/icons/Object.svg",
                    );
                  }

                  return GridView.builder(
                    itemCount: state.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 265,
                        ),
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return AllProductCardWidget(
                        product: product,
                        onTap: () {
                          context.push("/product/${product.id}");
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
