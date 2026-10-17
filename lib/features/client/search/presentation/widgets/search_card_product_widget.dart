import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_price.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_quality_badge.dart';

class SearchCardProductWidget extends StatelessWidget {
  const SearchCardProductWidget({
    super.key,
    required this.product,
    required this.onTap,
  });
  final VoidCallback? onTap;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.inputFieldAndCards,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/search/test2.png",
                  width: 95,
                  height: 95,
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: ProductQualityBadge(
                    quality: product.quality,
                    compact: true,
                  ),
                ),
              ],
            ),
            w12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.semiBoldCaption.copyWith(
                      color: AppColors.primaryText,
                    ),
                  ),
                  h4,
                  Text(
                    "رقم القطعة: ${product.partNumber}",
                    style: AppTextStyles.mediumOverline.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  h16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductPrice(price: product.price),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primaryButton,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
