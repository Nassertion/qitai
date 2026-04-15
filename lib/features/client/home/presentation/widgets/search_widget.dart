import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    this.readOnly = false,
    this.onTap,
  });

  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = _controller.text.trim().isNotEmpty;

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
          controller: _controller,
          readOnly: widget.readOnly,
          cursorWidth: 1.5,
          onTap: widget.onTap,
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
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                "assets/icons/search-normal.svg",
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            suffixIcon: !widget.readOnly && hasText
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                    },
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