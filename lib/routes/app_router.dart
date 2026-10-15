import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/widgets/main_shell_widget.dart';
import 'package:qitai/features/client/cart/presentation/screens/cart_screen.dart';
import 'package:qitai/features/client/categories/presentation/screens/categories_screen.dart';
import 'package:qitai/features/client/categories/presentation/screens/category_products_screen.dart';
import 'package:qitai/features/client/home/presentation/screens/client_home_screen.dart';
import 'package:qitai/features/client/orders/presentation/screens/orders_screen.dart';
import 'package:qitai/features/client/products/presentation/screens/all_products_screen.dart';
import 'package:qitai/features/client/products/presentation/screens/product_details_screen.dart';
import 'package:qitai/features/client/user/cars/presentation/screens/add_car_screen.dart';
import 'package:qitai/features/client/user/addresses/presentation/screens/client_addresses_screen.dart';
import 'package:qitai/features/client/user/cars/presentation/screens/client_cars_screen.dart';
import 'package:qitai/features/client/user/account/presentation/screens/edit_profile_screen.dart';
import 'package:qitai/features/client/user/account/presentation/screens/profile_screen.dart';
import 'package:qitai/features/client/notification/presentation/screens/notification_screen.dart';
import 'package:qitai/features/client/search/presentation/screens/search_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) {
    return const _RouteFallbackScreen(
      message: 'الصفحة المطلوبة غير متاحة.',
    );
  },
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
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/profile/edit',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/profile/adress',
      builder: (context, state) => const ClientAddressesScreen(),
    ),
    GoRoute(
      path: '/profile/cars',
      builder: (context, state) => const ClientCarsScreen(),
    ),
    GoRoute(
      path: '/profile/addCar',
      builder: (context, state) => const AddCarScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => const AllProductsScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = int.tryParse(
          state.pathParameters['id'] ?? '',
        );

        if (productId == null) {
          return const _RouteFallbackScreen(
            message: 'رابط المنتج غير صالح.',
          );
        }

        return ProductDetailsScreen(id: productId);
      },
    ),
    GoRoute(
      path: '/categories/:id',
      builder: (context, state) {
        final categoryId = int.tryParse(
          state.pathParameters['id'] ?? '',
        );

        if (categoryId == null) {
          return const _RouteFallbackScreen(
            message: 'رابط التصنيف غير صالح.',
          );
        }

        final queryName = state.uri.queryParameters['name'];
        final extra = state.extra;

        final name = queryName != null && queryName.trim().isNotEmpty
            ? queryName
            : extra is String && extra.trim().isNotEmpty
                ? extra
                : 'التصنيف';

        return CategoryProductsScreen(
          id: categoryId,
          name: name,
        );
      },
    ),
  ],
);
class _RouteFallbackScreen extends StatelessWidget {
  const _RouteFallbackScreen({
    this.message = 'حدث خطأ أثناء فتح الصفحة.',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.go('/'),
                  child: const Text('العودة للرئيسية'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}