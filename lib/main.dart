import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/theme/app_theme.dart';
import 'package:qitai/core/widgets/no_internet_widget.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/routes/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Qitai(),
    ),
  );
}

class Qitai extends ConsumerStatefulWidget {
  const Qitai({super.key});

  @override
  ConsumerState<Qitai> createState() => _QitaiState();
}

class _QitaiState extends ConsumerState<Qitai> {
  @override
  void initState() {
    super.initState();

    ref.read(authProvider.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final topPadding = MediaQuery.paddingOf(context).top;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              child!,
              Positioned(
                top: topPadding + 8,
                left: 0,
                right: 0,
                child: const Material(
                  color: Colors.transparent,
                  child: NoInternetWidget(),
                ),
              ),
            ],
          ),
        );
      },
      routerConfig: appRouter,
    );
  }
}