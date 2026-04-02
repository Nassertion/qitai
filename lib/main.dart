import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/features/client/cart/presentation/screens/cart_screen.dart';
import 'package:qitai/features/client/home/presentation/screens/client_home_screen.dart';
import 'package:qitai/features/client/notification/presentation/screens/notification_screen.dart';
import 'package:qitai/features/client/orders/presentation/screens/orders_screen.dart';
import 'package:qitai/features/client/profile/presentation/screens/profile_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.backgroudColor),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: ClientHomeScreen(),
      ),
    );
  }
}

// class Qitai extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError();
//   }
// }
