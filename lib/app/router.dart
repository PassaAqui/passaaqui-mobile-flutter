import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:passaaqui_mobile_flutter/features/home/screens/home_screen.dart';
import 'package:passaaqui_mobile_flutter/features/tourist/auth/screens/login_screen.dart';
import 'package:passaaqui_mobile_flutter/features/tourist/auth/screens/signup_screen.dart';
import 'package:passaaqui_mobile_flutter/features/tourist/map/presentation/views/map_screen.dart';
import 'package:passaaqui_mobile_flutter/features/tourist/shop/screens/global_shop_screen.dart';
import 'package:passaaqui_mobile_flutter/features/tourist/shop/screens/product_detail_screen.dart';

import 'navigation/scaffold_with_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorMapKey = GlobalKey<NavigatorState>(debugLabel: "shellMap");

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/map',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMapKey,
          routes: [
            GoRoute(
              path: "/map",
              builder: (context, state) => const MapScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/shop',
      name: 'shop',
      builder: (context, state) => const GlobalShopScreen(),
    ),
    GoRoute(
      path: '/shop/product/:productId',
      name: 'product-detail',
      builder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return ProductDetailScreen(productId: productId);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Página não encontrada: ${state.uri}')),
  ),
);
