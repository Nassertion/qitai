import 'package:flutter/material.dart';
import 'package:qitai/features/client/auth/presentation/widgets/otp_auth_content.dart';
import 'package:qitai/features/client/auth/presentation/widgets/phone_auth_content.dart';

class AuthFlowContent extends StatefulWidget {
  const AuthFlowContent({super.key});

  @override
  State<AuthFlowContent> createState() => _AuthFlowContentState();
}

class _AuthFlowContentState extends State<AuthFlowContent> {
  bool _showOtp = false;
  String? _phone;

  void _showOtpScreen(String phone) {
    setState(() {
      _phone = phone;
      _showOtp = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showOtp) {
      return OtpAuthContent(
        phone: _phone!,
      );
    }

    return PhoneAuthContent(
      onOtpSent: _showOtpScreen,
    );
  }
}