import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/products/presentation/provider/all_product_notifier.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicles_widget.dart';

class AllProductsScreen extends ConsumerStatefulWidget {
  const AllProductsScreen({super.key});

  @override
  ConsumerState<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends ConsumerState<AllProductsScreen> {
  late final VehicleNotifier _vehicleNotifier;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _vehicleNotifier = ref.read(vehicleProvider.notifier);

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    Future.microtask(() {
      _vehicleNotifier.clearAll();
      ref.read(allProductsProvider.notifier).loadProducts();
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(allProductsProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

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
            const VehiclesWidget(),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return const Center(
                      child: CustomLoading(),
                    );
                  }

                  if (state.errorMessage != null) {
                    return Center(
                      child: Text(state.errorMessage!),
                    );
                  }

                  if (state.products.isEmpty) {
                    return const EmptyDataWidget(
                      text: "لا توجد منتجات",
                      img: "assets/icons/Object.svg",
                    );
                  }

                  return GridView.builder(
                    controller: _scrollController,
                    itemCount: state.products.length +
                        (state.isLoadingMore ? 1 : 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 265,
                    ),
                    itemBuilder: (context, index) {
                      // آخر عنصر يظهر Loading أثناء تحميل الصفحة التالية.
                      if (index >= state.products.length) {
                        return const Center(
                          child: CustomLoading(),
                        );
                      }

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