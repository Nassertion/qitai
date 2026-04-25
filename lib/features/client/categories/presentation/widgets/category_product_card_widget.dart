import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/search/data/model/search_product_model.dart';

class CategoryProductCardWidget extends StatelessWidget {
  const CategoryProductCardWidget({super.key, required this.product , this.onTap});

  final SearchProductModel product;
    final VoidCallback? onTap;

  String get qualityLabel {
    switch (product.quality.toLowerCase()) {
      case 'oem':
        return 'أصلي';
      case 'aftermarket':
        return 'تجاري';
      default:
        return product.quality;
    }
  }

  bool get isAftermarket {
    return product.quality.toLowerCase() == 'aftermarket';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
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
                    'assets/images/test.png',
                    fit: BoxFit.contain,
                  ),
                ),
      
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
      
                    decoration: BoxDecoration(
                      color: isAftermarket ? AppColors.inputFieldAndCards : AppColors.actionText,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      qualityLabel,
                      style: AppTextStyles.semiBoldOverline.copyWith(
                        color: isAftermarket
                            ? AppColors.primaryText
                            : AppColors.whiteText,
                      ),
                    ),
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
                Row(
                  children: [
                    Text(
                      product.price,
                      style: AppTextStyles.semiBoldBody.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                    w2,
                    SvgPicture.asset("assets/icons/SR.svg"),
                  ],
                ),
      
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
