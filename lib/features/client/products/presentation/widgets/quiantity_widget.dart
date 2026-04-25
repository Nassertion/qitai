import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

class QuiantityWidget extends StatefulWidget {
  final int initialQuantity;

  const QuiantityWidget({super.key, required this.initialQuantity});

  @override
  State<QuiantityWidget> createState() => _QuiantityWidgetState();
}

class _QuiantityWidgetState extends State<QuiantityWidget> {
  static const int maxQuantity = 10000;

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialQuantity.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveQuantity() {
    final text = _controller.text.trim();
    final value = int.tryParse(text);

    if (value != null && value >= 1 && value <= maxQuantity) {
      Navigator.pop(context, value);
    } else {
      Navigator.pop(context, widget.initialQuantity);
    }
  }

  void _cancel() {
    Navigator.pop(context, widget.initialQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.actionText,
          selectionHandleColor: AppColors.actionText,
          selectionColor: Color(0x1F2196F3),
        ),
      ),
      child: Container(
        width: 270,
        padding: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.inputFieldAndCards,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.inputFieldAndCards,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      "الكمية",
                      style: AppTextStyles.semiBoldOverline.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    h4,
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.boldBody.copyWith(
                        color: AppColors.primaryText,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                      onSubmitted: (_) => _saveQuantity(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: AppColors.border, height: 1, thickness: 1),
            SizedBox(
              height: 48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _cancel,
                      child: Center(
                        child: Text(
                          "تراجع",
                          style: AppTextStyles.regularBody.copyWith(
                            color: AppColors.actionText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 1, color: AppColors.border),
                  Expanded(
                    child: InkWell(
                      onTap: _saveQuantity,
                      child: Center(
                        child: Text(
                          "التالي",
                          style: AppTextStyles.boldBody.copyWith(
                            color: AppColors.actionText,
                          ),
                        ),
                      ),
                    ),
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
