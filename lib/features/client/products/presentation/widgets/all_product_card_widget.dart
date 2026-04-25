import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/helpers/quality_helper.dart';
import 'package:qitai/features/client/search/data/model/search_product_model.dart';

class AllProductCardWidget extends StatelessWidget {
  const AllProductCardWidget({super.key, required this.product, this.onTap});

  final SearchProductModel product;
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
                    'assets/images/battery.png',
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
                      color: isAftermarket(product)
                          ? AppColors.inputFieldAndCards
                          : AppColors.actionText,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      qualityLabel(product),
                      style: AppTextStyles.semiBoldOverline.copyWith(
                        color: isAftermarket(product)
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
