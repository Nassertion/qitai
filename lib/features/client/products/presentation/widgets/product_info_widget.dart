import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/helpers/quality_helper.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/products/domain/entities/product_detail.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({super.key, required this.product});
  final ProductDetail product;


  @override
  Widget build(BuildContext context) {
    return AppPagePadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: AppTextStyles.boldBody.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          h4,
          Text(
            product.partNumber,
            style: AppTextStyles.mediumOverline.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          h12,
          Text(
            product.description,
            style: AppTextStyles.regularCaption.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          h12,
          Row(
            children: [
              Text(
                product.price.toString(),
                style: AppTextStyles.semiBoldBody.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
              w2,
              SvgPicture.asset("assets/icons/SR.svg"),
            ],
          ),
          Divider(color: AppColors.border),
          h8,
          Row(
            children: [
              Text(
                "الجودة: ",
                style: AppTextStyles.regularCaption.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              Text(
                qualityLabel(product.quality),
                style: AppTextStyles.semiBoldOverline.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          h4,
          Row(
            children: [
              Text(
                "التوافقية: ",
                style: AppTextStyles.regularCaption.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              Text(
                product.compatibilities
                    .map((e) => e.modelName ?? '')
                    .join(" - "),
                style: AppTextStyles.semiBoldOverline.copyWith(
                  color: AppColors.primaryText,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          h8,
          Divider(color: AppColors.border),
        ],
      ),
    );
  }
}
