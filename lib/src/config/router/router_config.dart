import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/authentication/landing/screens/landing_screen.dart';
import 'package:turf_touch/src/features/authentication/login/screens/login_screen.dart';
import 'package:turf_touch/src/features/authentication/signup/screens/signup_screen.dart';
import 'package:turf_touch/src/features/book_turf/screens/booking_history_screen.dart';
import 'package:turf_touch/src/features/book_turf/screens/home_screen.dart';
import 'package:turf_touch/src/features/book_turf/screens/notification_screen.dart';
import 'package:turf_touch/src/features/profile/screens/profile_screen.dart';
import 'package:turf_touch/src/shared/providers/bottom_bar_index_provider.dart';
import 'package:turf_touch/src/shared/widgets/bottom_bar.dart';
import 'package:turf_touch/src/shared/widgets/main_app_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

CustomTransitionPage buildPageWithDefaultTransition(
    {required BuildContext context,
    required GoRouterState state,
    required Widget child}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      // Change the opacity of the screen using a Curve based on the the animation's
      // value
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}

final goRouterConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/home",
  routes: [
    // auth routes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/login",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/auth_landing",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const LandingScreen(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/signup",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const SignupScreen(),
      ),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: Scaffold(
          backgroundColor: CTheme.of(context).theme.backgroundColor,
          appBar: const MainAppBar(),
          body: child,
          bottomNavigationBar: const TurfTouchBottomBar(),
          floatingActionButton: Consumer(
            builder: (context, ref, child) {
              final index = ref.watch(bottomBarIndexProvider);
              return SizedBox(
                height: 80,
                width: 80,
                child: FloatingActionButton(
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    ref.read(bottomBarIndexProvider.notifier).state = 1;
                    context.go("/home");
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: CTheme.of(context).theme.primaryColor),
                      color: CTheme.of(context).theme.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.home_outlined,
                      size: 35,
                      color: (index == 1)
                          ? CTheme.of(context).theme.primaryColor
                          : CTheme.of(context).theme.backgroundInverse,
                    ),
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: "/home",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: "/history",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const BookingHistory(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: "/notifications",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const NotificationScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/profile",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const ProfileScreen(),
      ),
    ),
  ],
);
