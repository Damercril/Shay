import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Services Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Paramètres',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const Divider(height: 1),
                _buildSettingItem(
                  context: context,
                  title: localizations.language,
                  icon: Icons.language,
                  onTap: () => _showLanguageDialog(context, localeProvider),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getLanguageName(localeProvider.locale.languageCode),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                const Divider(height: 1),
                _buildSettingItem(
                  context: context,
                  title: localizations.notifications,
                  icon: Icons.notifications_outlined,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fonctionnalité à venir'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                _buildSettingItem(
                  context: context,
                  title: 'Support',
                  icon: Icons.help_outline,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fonctionnalité à venir'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Logout Button
          ElevatedButton(
            onPressed: () {
              authProvider.logout();
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              localizations.logout,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'ar':
        return 'العربية';
      default:
        return code;
    }
  }

  Widget _buildSettingItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
      leading: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20.sp,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ?? Icon(Icons.chevron_right_rounded, size: 24.sp),
      onTap: onTap,
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required LocaleProvider localeProvider,
    required String languageCode,
    required String languageName,
    required String flagEmoji,
  }) {
    final bool isSelected = localeProvider.locale.languageCode == languageCode;
    
    return InkWell(
      onTap: () {
        localeProvider.setLocale(languageCode);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Text(
                flagEmoji,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              languageName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: AppTheme.primaryColor,
                  size: 20.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLanguageDialog(BuildContext context, LocaleProvider localeProvider) async {
    final localizations = AppLocalizations.of(context);
    
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 24.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      Text(
                        localizations.language,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.close_rounded, size: 24.sp),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                _buildLanguageOption(
                  context: context,
                  localeProvider: localeProvider,
                  languageCode: 'fr',
                  languageName: 'Français',
                  flagEmoji: '🇫🇷',
                ),
                _buildLanguageOption(
                  context: context,
                  localeProvider: localeProvider,
                  languageCode: 'en',
                  languageName: 'English',
                  flagEmoji: '🇬🇧',
                ),
                _buildLanguageOption(
                  context: context,
                  localeProvider: localeProvider,
                  languageCode: 'es',
                  languageName: 'Español',
                  flagEmoji: '🇪🇸',
                ),
                _buildLanguageOption(
                  context: context,
                  localeProvider: localeProvider,
                  languageCode: 'ar',
                  languageName: 'العربية',
                  flagEmoji: '🇸🇦',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
