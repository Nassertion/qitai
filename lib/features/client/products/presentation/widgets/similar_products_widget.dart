import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/home/presentation/widgets/card_product_widget.dart';

class SimilarProductsWidget extends StatelessWidget {
  const SimilarProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppPagePadding(
          child: Text(
            "منتجات مشابهة",
            style: AppTextStyles.boldBody.copyWith(
              color: AppColors.primaryText,
            ),
          ),
        ),
        h12,
        SizedBox(
          height: 260,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => w16,
            itemCount: 10,
            itemBuilder: (context, index) {
              return SizedBox(width: 160, child: ProductCard());
            },
          ),
        ),
      ],
    );
  }
}
