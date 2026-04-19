import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_info_widget.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_slide_widget.dart';
import 'package:qitai/features/client/products/presentation/widgets/add_to_cart_section.dart';
import 'package:qitai/features/client/products/presentation/widgets/similar_products_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "تفاصيل المنتج",
        action: Container(
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset("assets/icons/shopping-cart.svg"),
        ),
      ),
      body: ListView(
        // shrinkWrap: true,
        children: [
          ProductViewWidget(),
          dPadding,
          ProductInfoWidget(),
          dPadding,
          SimilarProductsWidget(),
          Padding12,
          AddToCartSection(),
          Padding8,
        ],
      ),
    );
  }
}
