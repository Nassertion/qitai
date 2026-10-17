
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';

class CategoryFilterField extends StatelessWidget {
  const CategoryFilterField({
    super.key,
    required this.title,
    this.onTap,
    required this.isSelectedStyle,
    this.onDelete,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isSelectedStyle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isSelectedStyle ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelectedStyle
                  ? AppColors.actionText
                  : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.inputFieldAndCards,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    title,
                    maxLines: 1,
                    softWrap: false,
                    overflow: isSelectedStyle
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: isSelectedStyle
                        ? AppTextStyles.mediumCaption.copyWith(
                            color: AppColors.actionText,
                            height: 1.2,
                          )
                        : AppTextStyles.regularOverline.copyWith(
                            color: AppColors.secondaryText,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              if (isSelectedStyle)
                InkWell(
                  onTap: onDelete,
                  customBorder: const CircleBorder(),
                  child: SvgPicture.asset(
                    'assets/icons/close-circle.svg',
                    height: 14,
                    width: 14,
                  ),
                )
              else
                SvgPicture.asset(
                  'assets/icons/arrow-down.svg',
                  height: 14,
                  width: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
