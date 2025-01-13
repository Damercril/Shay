import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayniss/core/enums/user_type.dart';
import 'package:shayniss/features/auth/screens/login_screen.dart';
import 'package:shayniss/features/auth/screens/register_screen.dart';
import 'package:shayniss/features/auth/screens/client_register_screen.dart';
import 'package:shayniss/features/auth/screens/professional_register_screen.dart';
import 'package:shayniss/features/client/screens/client_main_screen.dart';
import 'package:shayniss/features/client/screens/profile/addresses_screen.dart';
import 'package:shayniss/features/client/screens/profile/favorites_screen.dart';
import 'package:shayniss/features/client/screens/profile/help_support_screen.dart';
import 'package:shayniss/features/client/screens/profile/language_screen.dart';
import 'package:shayniss/features/client/screens/profile/notifications_screen.dart';
import 'package:shayniss/features/client/screens/profile/personal_info_screen.dart';
import 'package:shayniss/features/client/screens/profile/payment_methods_screen.dart';
import 'package:shayniss/features/client/screens/profile/security_screen.dart';
import 'package:shayniss/features/onboarding/screens/onboarding_screen.dart';
import 'package:shayniss/features/professional/screens/pro_home_screen.dart';
import 'package:shayniss/features/settings/screens/settings_screen.dart';

class AppRouter {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      // Ne pas rediriger si nous sommes sur une route d'inscription
      if (state.matchedLocation.startsWith('/register')) {
        return null;
      }

      final hasSeenOnboarding = _prefs.getBool('hasSeenOnboarding') ?? false;
      if (!hasSeenOnboarding) {
        return '/onboarding';
      }
      
      final isAuthenticated = _prefs.getString('isAuthenticated') == 'true';
      if (!isAuthenticated && !state.matchedLocation.startsWith('/login')) {
        return '/login';
      }
      
      if (isAuthenticated) {
        final userType = _prefs.getString('userType');
        if (userType == UserType.professional.toString()) {
          return '/professional';
        }
        return '/client';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
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
        path: '/register/client',
        builder: (context, state) => const ClientRegisterScreen(),
      ),
      GoRoute(
        path: '/register/professional',
        builder: (context, state) => const ProfessionalRegisterScreen(),
      ),
      GoRoute(
        path: '/client',
        builder: (context, state) => const ClientMainScreen(),
        routes: [
          GoRoute(
            path: 'personal-info',
            builder: (context, state) => const PersonalInfoScreen(),
          ),
          GoRoute(
            path: 'addresses',
            builder: (context, state) => const AddressesScreen(),
          ),
          GoRoute(
            path: 'payment-methods',
            builder: (context, state) => const PaymentMethodsScreen(),
          ),
          GoRoute(
            path: 'security',
            builder: (context, state) => const SecurityScreen(),
          ),
          GoRoute(
            path: 'language',
            builder: (context, state) => const LanguageScreen(),
          ),
          GoRoute(
            path: 'help-support',
            builder: (context, state) => const HelpSupportScreen(),
          ),
          GoRoute(
            path: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            path: 'notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/professional',
        builder: (context, state) => const ProHomeScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
