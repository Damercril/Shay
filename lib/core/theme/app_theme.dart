import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Couleurs principales
  static const Color primaryColor = Color(0xFF8A2BE2);  // Violet vif
  static const Color primaryLightColor = Color(0xFFB980F0); // Violet clair
  static const Color primaryDarkColor = Color(0xFF4A148C); // Violet foncé
  static const Color secondaryColor = Color(0xFFB980F0); // Pour la compatibilité
  
  // Couleurs d'accent
  static const Color accentColor = Color(0xFFFF63B3); // Rose accent
  static const Color accentLightColor = Color(0xFFFF85C6);
  static const Color accentDarkColor = Color(0xFFB34580);

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
      Color(0xFF8A2BE2), // Violet vif
      Color(0xFF9945FF), // Violet plus clair
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [
      Color(0xFFFF63B3), // Rose accent
      Color(0xFFFF85C6), // Rose clair
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      Color(0xFF4A148C), // Violet très foncé
      Color(0xFF8A2BE2), // Violet profond
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient storyGradient = LinearGradient(
    colors: [
      Color(0xFF8A2BE2),
      Color(0xFFB980F0),
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
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    cardColor: cardColor,
    dividerColor: dividerColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: primaryLightColor,
      surface: surfaceColor,
      background: scaffoldBackgroundColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: textColor,
      onSurface: textColor,
      onBackground: textColor,
      onError: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      foregroundColor: textColor,
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(
      color: textColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: TextStyle(color: textColor, fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: primaryButton,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: outlinedButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: errorColor),
      ),
      contentPadding: const EdgeInsets.all(16),
    ),
    cardTheme: CardTheme(
      color: surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
    ),
  );
}
