import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/widgets/main_shell_widget.dart';
import 'package:qitai/features/client/cart/presentation/screens/cart_screen.dart';
import 'package:qitai/features/client/categories/presentation/screens/categories_screen.dart';
import 'package:qitai/features/client/classification/presentation/widgets/classification_widget.dart';
import 'package:qitai/features/client/home/presentation/screens/client_home_screen.dart';
import 'package:qitai/features/client/orders/presentation/screens/orders_screen.dart';
import 'package:qitai/features/client/profile/presentation/screens/profile_screen.dart';
import 'package:qitai/features/client/notification/presentation/screens/notification_screen.dart';
import 'package:qitai/features/client/search/presentation/screens/search_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return MainShellScreen(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const ClientHomeScreen(),
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrdersScreen(),
        ),
        GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    // GoRoute(path: '/test', builder: (context, state) => const ClassificationScreen()),
    GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
    //  GoRoute(
    //     path: '/categories/:name',
    //     builder: (context, state) {
    //       final category = state.pathParameters['name'] ?? '';
    //       return CategoryScreen(category: category);
    //     },
    //   ),
  ],
);
