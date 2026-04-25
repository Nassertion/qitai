import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/widgets/main_shell_widget.dart';
import 'package:qitai/features/client/cart/presentation/screens/cart_screen.dart';
import 'package:qitai/features/client/categories/presentation/screens/categories_screen.dart';
import 'package:qitai/features/client/categories/presentation/screens/category_search_screen.dart';
import 'package:qitai/features/client/home/presentation/screens/client_home_screen.dart';
import 'package:qitai/features/client/orders/presentation/screens/orders_screen.dart';
import 'package:qitai/features/client/products/presentation/screens/all_product_screen.dart';
import 'package:qitai/features/client/products/presentation/screens/product_detail_screen.dart';
import 'package:qitai/features/client/profile/presentation/screens/client_adresses_screen.dart';
import 'package:qitai/features/client/profile/presentation/screens/client_cars_screen.dart';
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
          path: '/profile/adress',
          builder: (context, state) => const ClientAdressesScreen(),
        ),
                GoRoute(
          path: '/profile/car',
          builder: (context, state) => const ClientCarsScreen(),
        ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
    GoRoute(path: '/products', builder: (context, state) => const AllProductsScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;

        return ProductDetailScreen(id: int.parse(productId));
      },
    ),
      GoRoute(
        path: '/categories/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final name = state.extra as String;
          return CategorySearchScreen( id : int.parse(id) , name: name,);
        },
      ),
  ],
);
