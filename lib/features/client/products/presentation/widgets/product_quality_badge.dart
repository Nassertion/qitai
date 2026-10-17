import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/products/presentation/utils/quality_helper.dart';

class ProductQualityBadge extends StatelessWidget {
  const ProductQualityBadge({
    super.key,
    required this.quality,
    this.compact = false,
  });

  final String quality;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final aftermarket = isAftermarket(quality);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 10,
        vertical: compact ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: aftermarket
            ? AppColors.inputFieldAndCards
            : AppColors.actionText,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        qualityLabel(quality),
        style: AppTextStyles.semiBoldOverline.copyWith(
          color: aftermarket ? AppColors.primaryText : AppColors.whiteText,
        ),
      ),
    );
  }
}
