import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/search/data/model/search_product_model.dart';

class SearchCardProductWidget extends StatelessWidget {
  const SearchCardProductWidget({
    super.key,
    required this.product,
    required this.onTap,
  });
  final VoidCallback? onTap;
  final SearchProductModel product;

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
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isAftermarket
                          ? AppColors.inputFieldAndCards
                          : AppColors.actionText,
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
