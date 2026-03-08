import 'package:flutter/material.dart';

class AppPagePadding extends StatelessWidget {
  final Widget child;

  const AppPagePadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //real data
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}
