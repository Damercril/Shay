import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayniss/core/enums/user_type.dart';
import 'package:shayniss/features/auth/screens/login_screen.dart';
import 'package:shayniss/features/auth/screens/register_screen.dart';
import 'package:shayniss/features/client/screens/client_main_screen.dart';
import 'package:shayniss/features/onboarding/screens/onboarding_screen.dart';
import 'package:shayniss/features/professional/screens/pro_home_screen.dart';
import 'package:shayniss/core/providers/auth_provider.dart';

class AppRouter {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final hasSeenOnboarding = _prefs.getBool('hasSeenOnboarding') ?? false;
          if (!hasSeenOnboarding) {
            return const OnboardingScreen();
          }
          final authProvider = context.read<AuthProvider>();
          if (!authProvider.isAuthenticated) {
            return const LoginScreen();
          }
          return authProvider.userType == UserType.professional
              ? const ProHomeScreen()
              : const ClientMainScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/client',
        builder: (context, state) => const ClientMainScreen(),
      ),
      GoRoute(
        path: '/professional',
        builder: (context, state) => const ProHomeScreen(),
      ),
    ],
  );
}
