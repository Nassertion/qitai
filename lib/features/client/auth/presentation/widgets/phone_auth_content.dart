import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

class PhoneAuthContent extends StatefulWidget {
  const PhoneAuthContent({super.key});

  @override
  State<PhoneAuthContent> createState() => _PhoneAuthContentState();
}

class _PhoneAuthContentState extends State<PhoneAuthContent> {
  final TextEditingController _phoneController = TextEditingController();

  bool get _isValidPhone {
    final phone = _phoneController.text.trim();
    return phone.length == 9 && phone.startsWith('5');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'سجل أو قم بتسجيل الدخول في قطعي لتتمكن من استخدام ميزات التطبيق.',
          style: AppTextStyles.mediumOverline,
        ),

        h16,

        const Text(
          'رقم الجوال',
          textAlign: TextAlign.right,
          style: AppTextStyles.mediumCaption,
        ),

        h8,

        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 35,
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                  maxLength: 9,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                  onChanged: (_) {
                    setState(() {});
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: '*******50',
                    counterText: '',
                    filled: true,

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      // vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.onPrimary),
                    ),
                  ),
                ),
              ),
            ),
            w8,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('966+', style: AppTextStyles.regularOverline),
                  w8,
                  SvgPicture.asset(
                    "assets/images/SA/Flags.svg",
                    width: 22,
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),

        h16,

        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('أو'),
            ),
            Expanded(child: Divider()),
          ],
        ),

        h16,

        SizedBox(
          height: 40,
          child: OutlinedButton(
            onPressed: () {
              // Google later
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // side: BorderSide(width: 20, color: AppColors.border),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/google.svg"),
                w12,
                Text(
                  'قم بالتسجيل عن طريق قوقل',
                  style: AppTextStyles.regularOverline.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ),

        h16,

        SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: _isValidPhone
                ? () {
                    // Send OTP later
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isValidPhone
                  ? AppColors.primaryButton
                  : AppColors.disabledButton,
              // backgroundColor: AppColors.disabledButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'التالي',
              style: AppTextStyles.boldBody.copyWith(
                color: _isValidPhone
                    ? AppColors.surface
                    : AppColors.disabledText,
              ),
            ),
          ),
        ),

        SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 4),
      ],
    );
  }
}
