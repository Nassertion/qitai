import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_info_widget.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_slide_widget.dart';
import 'package:qitai/features/client/products/presentation/widgets/add_to_cart_section.dart';
import 'package:qitai/features/client/products/presentation/widgets/similar_products_widget.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailAsync = ref.watch(producDetailtProvider(id));
    return Scaffold(
      bottomNavigationBar: const SafeArea(child: AddToCartSection()),
      appBar: CustomAppbar(
        title: "تفاصيل المنتج",
        action: Container(
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset("assets/icons/shopping-cart.svg"),
        ),
      ),
      body: productDetailAsync.when(
        loading: () => Center(child: CustomLoading()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (data) => ListView(
          children: [
            ProductViewWidget(),
            dPadding,
            ProductInfoWidget(product: data),
            dPadding,
            SimilarProductsWidget(),
            Padding12,
          ],
        ),
      ),
    );
  }
}
