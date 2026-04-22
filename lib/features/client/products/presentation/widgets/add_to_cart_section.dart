import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/products/presentation/widgets/quiantity_widget.dart';

class AddToCartSection extends StatefulWidget {
  const AddToCartSection({super.key});

  @override
  State<AddToCartSection> createState() => _AddToCartSectionState();
}

class _AddToCartSectionState extends State<AddToCartSection> {
  int quantity = 1;

  Future<void> _openQuantityDialog() async {
    final result = await showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: QuiantityWidget(initialQuantity: quantity),
      ),
    );

    if (result != null) {
      setState(() {
        quantity = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border),
        ),
        color: AppColors.backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AppPagePadding(
        child: Row(
          children: [
            GestureDetector(
              onTap: _openQuantityDialog,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  color: AppColors.inputFieldAndCards,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "الكمية",
                      style: AppTextStyles.semiBoldOverline.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    h4,
                    Text(
                      quantity.toString(),
                      style: AppTextStyles.mediumOverline.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            w12,
            Expanded(child: ButtonWidget(text: "أضف للسلة")),
          ],
        ),
      ),
    );
  }
}
