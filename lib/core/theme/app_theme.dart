import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.backgroundColor,

    colorScheme: const ColorScheme.light(
      primary: AppColors.actionText,
      onPrimary: AppColors.onPrimary,

      secondary: AppColors.primaryButton,
      onSecondary: AppColors.whiteText,

      surface: AppColors.surface,
      onSurface: AppColors.onSurface,

      error: AppColors.errorText,
      onError: AppColors.whiteText,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: AppColors.primaryText,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),

    splashColor: AppColors.actionText.withValues(alpha: 0.10),
    highlightColor: AppColors.actionText.withValues(alpha: 0.05),
    hoverColor: AppColors.actionText.withValues(alpha: 0.05),
    focusColor: AppColors.actionText.withValues(alpha: 0.08),

    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    ),

    iconTheme: const IconThemeData(color: AppColors.primaryText),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFieldAndCards,

      hintStyle: const TextStyle(color: AppColors.secondaryText),

      labelStyle: const TextStyle(color: AppColors.secondaryText),

      prefixIconColor: AppColors.secondaryText,
      suffixIconColor: AppColors.secondaryText,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.border),
      ),

      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.border),
      ),

      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.actionText, width: 1.5),
      ),

      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.errorText),
      ),

      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.errorText, width: 1.5),
      ),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.actionText,
      selectionColor: Color(0x331B7CD0),
      selectionHandleColor: AppColors.actionText,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.actionText,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.actionText;
        }

        return Colors.transparent;
      }),
      side: const BorderSide(color: AppColors.secondaryText),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.actionText;
        }

        return AppColors.secondaryText;
      }),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.actionText;
        }

        return AppColors.disabledButton;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.actionText.withValues(alpha: 0.35);
        }

        return AppColors.image;
      }),
    ),
  );
}
