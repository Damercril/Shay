import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Couleurs principales
  static const Color primaryColor = Color(0xFF8A6FE8); // Violet principal
  static const Color secondaryColor = Color(0xFFE0D0FF); // Violet clair
  static const Color accentColor = Color(0xFF6B4E9E); // Violet foncé

  // Couleurs d'accent
  static const Color accentLightColor = Color(0xFF9D84E8); // Violet moyen
  static const Color accentDarkColor = Color(0xFF7B5FE8); // Violet foncé

  // Couleurs de fond
  static const Color scaffoldBackgroundColor = Colors.white;
  static const Color cardColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  static const Color backgroundColor = Colors.white;

  // Couleurs de texte
  static const Color textColor = Color(0xFF1A1A1A); // Presque noir pour meilleur contraste
  static const Color subtitleColor = Color(0xFF666666); // Gris foncé
  static const Color dividerColor = Color(0xFFEEEEEE); // Gris très clair

  // Espacements
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Couleurs d'état
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE53935);
  static const Color warningColor = Color(0xFFFFA726);
  static const Color infoColor = Color(0xFF2196F3);

  // Dégradés
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFE0D0FF), // Violet très clair
      Color(0xFFF1EBFF), // Violet clair chromé
      Color(0xFFE8E1FF), // Violet clair brillant
      Color(0xFFEEE6FF), // Violet clair métallique
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [
      Color(0xFF9D84E8), // Violet moyen
      Color(0xFF8A6FE8), // Violet
      Color(0xFF7B5FE8), // Violet foncé
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      Color(0xFFE0D0FF), // Violet clair
      Color(0xFFD3C4FF), // Violet clair foncé
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient storyGradient = LinearGradient(
    colors: [
      Color(0xFFE0D0FF), // Violet clair
      Color(0xFFD3C4FF), // Violet clair foncé
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Rayons de bordure
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 24.0;

  // Ombres
  static List<BoxShadow> get shadowSmall => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowMedium => [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowLarge => [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  // Styles de texte
  static TextStyle get headingLarge => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5,
  );

  static TextStyle get headingMedium => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5,
  );

  static TextStyle get headingSmall => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    color: textColor,
  );

  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    color: subtitleColor,
  );

  static TextStyle get buttonText => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Styles de boutons
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadiusLarge),
    ),
  );

  static ButtonStyle get outlinedButton => OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadiusLarge),
    ),
  );

  static ButtonStyle get textButton => TextButton.styleFrom(
    foregroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadiusLarge),
    ),
  );

  // Thème clair
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    cardColor: cardColor,
    dividerColor: dividerColor,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: const TextStyle(color: textColor),
      displayMedium: const TextStyle(color: textColor),
      displaySmall: const TextStyle(color: textColor),
      headlineLarge: const TextStyle(color: textColor),
      headlineMedium: const TextStyle(color: textColor),
      headlineSmall: const TextStyle(color: textColor),
      titleLarge: const TextStyle(color: textColor),
      titleMedium: const TextStyle(color: textColor),
      titleSmall: const TextStyle(color: textColor),
      bodyLarge: const TextStyle(color: textColor),
      bodyMedium: const TextStyle(color: textColor),
      bodySmall: const TextStyle(color: subtitleColor),
      labelLarge: const TextStyle(color: textColor),
      labelMedium: const TextStyle(color: textColor),
      labelSmall: const TextStyle(color: textColor),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: textColor,
      onBackground: textColor,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
  );
}
