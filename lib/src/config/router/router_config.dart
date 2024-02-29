import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/authentication/landing/screens/landing_screen.dart';
import 'package:turf_touch/src/features/authentication/login/screens/login_screen.dart';
import 'package:turf_touch/src/features/authentication/signup/screens/signup_screen.dart';
import 'package:turf_touch/src/features/book_turf/screens/book_turf_screen.dart';
import 'package:turf_touch/src/shared/widgets/app_bar.dart';
import 'package:turf_touch/src/shared/widgets/bottom_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final goRouterConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/home",
  routes: [
    // auth routes
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: "/auth_landing",
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: "/signup",
      builder: (context, state) => const SignupScreen(),
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return Scaffold(
            backgroundColor: CTheme.of(context).theme.backgroundColor,
            appBar: const TurfTouchAppBar(),
            body: child,
            bottomNavigationBar: const TurfTouchBottomBar(),
            floatingActionButton: SizedBox(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)),
                elevation: 0,
                backgroundColor: Colors.transparent,
                onPressed: () {},
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.home),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
        routes: [
          GoRoute(
            path: "/home",
            builder: (context, state) => const BookTurfScreen(),
          ),
        ])
  ],
);
