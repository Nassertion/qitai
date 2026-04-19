import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/page_padding.dart' show AppPagePadding;
import 'package:qitai/features/client/home/presentation/widgets/card_product_widget.dart';

class SimilarProductsWidget extends StatelessWidget {
  const SimilarProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [          AppPagePadding(
            child: Text(
              "منتجات مشابهة",
              textAlign: TextAlign.start,
              style: AppTextStyles.boldBody.copyWith(
                color: AppColors.primaryText,
              ),
            ),
          ),
          Padding12,
          SizedBox(
            height: 260,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return SizedBox(width: 160, child: ProductCard());
              },
            ),
          ),],);
  }
}