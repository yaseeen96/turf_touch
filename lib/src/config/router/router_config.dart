import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/features/authentication/landing/screens/landing_screen.dart';
import 'package:turf_touch/src/features/authentication/login/screens/login_screen.dart';
import 'package:turf_touch/src/features/authentication/signup/screens/signup_screen.dart';

final goRouterConfig = GoRouter(
  initialLocation: "/auth_landing",
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
  ],
);
