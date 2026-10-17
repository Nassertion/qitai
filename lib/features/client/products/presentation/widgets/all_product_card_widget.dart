import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_price.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_quality_badge.dart';

class AllProductCardWidget extends StatelessWidget {
  const AllProductCardWidget({super.key, required this.product, this.onTap});

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 163,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.image,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/placeholder.jpg',
                    fit: BoxFit.contain,
                  ),
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
            h8,
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.semiBoldOverline.copyWith(
                color: AppColors.primaryText,
              ),
            ),
            h4,
            Text(
              "رقم القطعة: ${product.partNumber}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regularOverline.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
            h8,
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
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
