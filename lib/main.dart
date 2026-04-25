import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: Qitai()));
}

class Qitai extends StatelessWidget {
  const Qitai({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      routerConfig: appRouter,
    );
  }
}

// class Qitai extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError();
//   }
// }
