import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'app_theme.dart';
import 'app_text_styles.dart';

class AppComponents {
  // Bouton principal
  static Widget primaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    EdgeInsets? padding,
  }) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLarge,
          vertical: AppTheme.spacingMedium,
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Text(text, style: AppTextStyles.buttonLarge),
    );
  }

  // Bouton secondaire
  static Widget outlinedButton({
    required String text,
    required VoidCallback onPressed,
    EdgeInsets? padding,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLarge,
          vertical: AppTheme.spacingMedium,
        ),
      ),
      child: Text(text),
    );
  }

  // Champ de texte personnalisé
  static Widget textField({
    required String label,
    required TextEditingController controller,
    String? hint,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: inputFormatters,
    );
  }

  // Carte de service
  static Widget serviceCard({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
    String? subtitle,
    String? price,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.borderRadiusMedium),
              ),
              child: Image.asset(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.heading3),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppTheme.spacingSmall),
                    Text(subtitle, style: AppTextStyles.bodyMedium),
                  ],
                  if (price != null) ...[
                    const SizedBox(height: AppTheme.spacingSmall),
                    Text(price, style: AppTextStyles.price),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Badge de notification
  static Widget notificationBadge({
    required Widget child,
    required int count,
    Color? color,
  }) {
    return Stack(
      children: [
        child,
        if (count > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color ?? AppTheme.errorColor,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                count.toString(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  // Icône SVG avec couleur personnalisée
  static Widget svgIcon(
    String assetName, {
    double? size,
    Color? color,
  }) {
    return SvgPicture.asset(
      assetName,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }
}
