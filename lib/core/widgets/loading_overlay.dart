import 'package:flutter/material.dart';
import 'package:qitai/core/widgets/loading_widget.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.child,
    this.isLoading = false,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }

    return Stack(
      children: [
        child,

        Positioned.fill(
          child: ColoredBox(
            color: Colors.black.withValues(alpha: 0.15),
            child: const Center(
              child: CustomLoading(),
            ),
          ),
        ),
      ],
    );
  }
}