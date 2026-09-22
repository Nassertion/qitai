import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/auth/presentation/widgets/auth_bottom_sheet.dart';
import 'package:qitai/features/client/auth/presentation/widgets/auth_flow_content.dart';

Future<void> requireAuth({
  required BuildContext context,
  required WidgetRef ref,
  required VoidCallback onAuthenticated,
}) async {
  final authNotifier = ref.read(authProvider.notifier);

  if (ref.read(authProvider) is AuthInitial) {
    await authNotifier.initialize();
  }

  final authState = ref.read(authProvider);

  if (authState is Authenticated) {
    onAuthenticated();
    return;
  }

  if (!context.mounted) {
    return;
  }

  await AuthBottomSheet.show(
    context: context,
    child: const AuthFlowContent(),
  );

  if (ref.read(authProvider) is Authenticated) {
    onAuthenticated();
  }
}