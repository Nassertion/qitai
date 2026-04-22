import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onClear,
    this.onFieldSubmitted,
    this.onSearchTap,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    final bool hasText = controller?.text.trim().isNotEmpty ?? false;
    return SizedBox(
      height: 44,
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.actionText,
            selectionHandleColor: AppColors.actionText,
            selectionColor: Color(0x1F2196F3),
          ),
        ),
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          cursorWidth: 1.5,
          onTap: onTap,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          style: AppTextStyles.mediumCaption.copyWith(
            color: AppColors.primaryText,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.inputFieldAndCards,
            hintText: "ابحث برقم الشاصي أو القطعة ورقمها",
            hintStyle: AppTextStyles.regularOverline.copyWith(
              color: AppColors.secondaryText,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            prefixIcon: GestureDetector(
              onTap: onSearchTap,
    
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  "assets/icons/search-normal.svg",
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            suffixIcon: !readOnly && hasText
                ? IconButton(
                    onPressed: onClear,
                    icon: SvgPicture.asset(
                      "assets/icons/close-circle-search.svg",
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(231, 233, 234, 1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(231, 233, 234, 1),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(231, 233, 234, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
