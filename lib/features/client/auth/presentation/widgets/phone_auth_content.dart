import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';

class PhoneAuthContent extends ConsumerStatefulWidget {
  final void Function(String phone) onOtpSent;

  const PhoneAuthContent({
    super.key,
    required this.onOtpSent,
  });

  @override
  ConsumerState<PhoneAuthContent> createState() => _PhoneAuthContentState();
}

class _PhoneAuthContentState extends ConsumerState<PhoneAuthContent> {
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;

  bool get _isValidPhone {
    final phone = _phoneController.text.trim();

    return phone.length == 9 && phone.startsWith('5');
  }

  Future<void> _sendOtp() async {
    if (!_isValidPhone || _isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final phone = '0${_phoneController.text.trim()}';

    try {
      await ref.read(authProvider.notifier).sendOtp(phone);

      if (!mounted) {
        return;
      }

      widget.onOtpSent(phone);
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  maxLength: 9,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: '*******50',
                    counterText: '',
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            w8,

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.border,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '966+',
                    style: AppTextStyles.regularOverline,
                  ),
                  w8,
                  SvgPicture.asset(
                    'assets/images/SA/Flags.svg',
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
            Expanded(
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('أو'),
            ),
            Expanded(
              child: Divider(),
            ),
          ],
        ),

        h16,

        SizedBox(
          height: 40,
          child: OutlinedButton(
            onPressed: _isLoading
                ? null
                : () {
                    // Google later
                  },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppColors.border,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/google.svg',
                ),
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
            onPressed: _isValidPhone && !_isLoading
                ? _sendOtp
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isValidPhone && !_isLoading
                  ? AppColors.primaryButton
                  : AppColors.disabledButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'التالي',
                    style: AppTextStyles.boldBody.copyWith(
                      color: _isValidPhone
                          ? Colors.white
                          : AppColors.disabledText,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}