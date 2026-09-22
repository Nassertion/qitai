import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';

class OtpAuthContent extends ConsumerStatefulWidget {
  final String phone;

  const OtpAuthContent({super.key, required this.phone});

  @override
  ConsumerState<OtpAuthContent> createState() => _OtpAuthContentState();
}

class _OtpAuthContentState extends ConsumerState<OtpAuthContent> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  bool _isLoading = false;
  bool _hasOtpError = false;

  Timer? _timer;
  int _remainingSeconds = 54;

  bool get _isValidOtp {
    return _controllers.every(
      (controller) => controller.text.trim().isNotEmpty,
    );
  }

  String get _otpCode {
    return _controllers.map((controller) => controller.text).join();
  }

  bool get _canResend {
    return _remainingSeconds == 0 && !_isLoading;
  }

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(6, (_) => TextEditingController());

    _focusNodes = List.generate(6, (_) => FocusNode());

    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes.first.requestFocus();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        return;
      }

      if (mounted) {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (!_isValidOtp || _isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(authProvider.notifier)
          .verifyOtp(phone: widget.phone, code: _otpCode);

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _hasOtpError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(authProvider.notifier).sendOtp(widget.phone);

      if (!mounted) {
        return;
      }

      setState(() {
        _remainingSeconds = 54;
        _hasOtpError = false;
      });

      _startTimer();
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onCodeChanged(String value, int index) {
    if (value.length > 1) {
      _controllers[index].text = value.substring(value.length - 1);

      _controllers[index].selection = TextSelection.collapsed(
        offset: _controllers[index].text.length,
      );
    }

    setState(() {
      _hasOtpError = false;
    });

    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  KeyEventResult _handleKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();

      setState(() {
        _hasOtpError = false;
      });

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  String _formattedTime() {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');

    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();

    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'ادخل رمز التحقق المرسل لرقم هاتفك',
          textAlign: TextAlign.right,
          style: AppTextStyles.boldBody,
        ),

        h16,

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.ltr,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 44,
              height: 44,
              child: Focus(
                onKeyEvent: (node, event) {
                  return _handleKeyEvent(event, index);
                },
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  onChanged: (value) {
                    _onCodeChanged(value, index);
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.onPrimary),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        if (_hasOtpError) ...[
          h8,
          Text(
            'الرمز المدخل غير صحيح حاول مرة أخرى',
            textAlign: TextAlign.center,
            style: AppTextStyles.regularOverline.copyWith(
              color: AppColors.errorText,
            ),
          ),
        ],

        h16,

        SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: _isValidOtp && !_isLoading ? _verifyOtp : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isValidOtp && !_isLoading
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
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'التحقق',
                    style: AppTextStyles.boldBody.copyWith(
                      color: _isValidOtp
                          ? Colors.white
                          : AppColors.disabledText,
                    ),
                  ),
          ),
        ),

        h16,
        Text(
          "لم يصلك الرمز؟",
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumCaption.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
        h8,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            GestureDetector(
              onTap: _canResend ? _resendOtp : null,
              child: Text(
                'أعد الإرسال',
                style: AppTextStyles.boldBody.copyWith(
                  color: _canResend
                      ? AppColors.primaryButton
                      : AppColors.disabledText,
                ),
              ),
            ),

            w16,

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FC),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _formattedTime(),
                style: AppTextStyles.boldOverline.copyWith(
                  color: AppColors.primaryButton,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
