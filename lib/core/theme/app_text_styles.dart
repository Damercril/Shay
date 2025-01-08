import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';

class AppTextStyles {
  // Titres
  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor,
      );

  static TextStyle get heading3 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor,
      );

  // Corps du texte
  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16,
        color: AppTheme.textColor,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14,
        color: AppTheme.textColor,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 12,
        color: AppTheme.subtitleColor,
      );

  // Boutons
  static TextStyle get buttonLarge => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle get buttonMedium => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  // Liens
  static TextStyle get link => GoogleFonts.poppins(
        fontSize: 14,
        color: AppTheme.primaryColor,
        decoration: TextDecoration.underline,
      );

  // Prix
  static TextStyle get price => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor,
      );

  // Étiquettes
  static TextStyle get label => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppTheme.subtitleColor,
      );

  // Erreurs
  static TextStyle get error => GoogleFonts.poppins(
        fontSize: 12,
        color: AppTheme.errorColor,
      );
}
