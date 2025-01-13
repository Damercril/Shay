import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_components.dart';
import '../../../core/providers/locale_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/images/onboarding_first.png',
      title: 'Trouvez les meilleurs professionnels',
      description:
          'Découvrez des experts de la beauté qualifiés près de chez vous',
    ),
    OnboardingPage(
      image: 'assets/images/onboarding_second.png',
      title: 'Réservez en quelques clics',
      description:
          'Prenez rendez-vous facilement et gérez votre agenda en temps réel',
    ),
    OnboardingPage(
      image: 'assets/images/onboarding_third.png',
      title: 'Partagez votre expérience',
      description:
          'Donnez votre avis et gagnez des récompenses en recommandant vos services préférés',
    ),
  ];

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    if (!mounted) return;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<LocaleProvider>(
                    builder: (context, localeProvider, _) => GestureDetector(
                      onTap: () => _showLanguageBottomSheet(context, localeProvider),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.language_rounded,
                                size: 16.sp,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              _getLanguageEmoji(localeProvider.locale.languageCode),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  String _getLanguageEmoji(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return '🇫🇷';
      case 'en':
        return '🇬🇧';
      case 'es':
        return '🇪🇸';
      case 'ar':
        return '🇸🇦';
      default:
        return '🇫🇷';
    }
  }

  void _showLanguageBottomSheet(BuildContext context, LocaleProvider localeProvider) {
    showModalBottomSheet<void>(
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
                        'Langue',
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
                SizedBox(height: 8.h),
                _buildLanguageOption(
                  context: context,
                  localeProvider: localeProvider,
                  languageCode: 'en',
                  languageName: 'English',
                  flagEmoji: '🇬🇧',
                ),
                SizedBox(height: 8.h),
                _buildLanguageOption(
                  context: context,
                  localeProvider: localeProvider,
                  languageCode: 'es',
                  languageName: 'Español',
                  flagEmoji: '🇪🇸',
                ),
                SizedBox(height: 8.h),
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
            Text(
              flagEmoji,
              style: TextStyle(fontSize: 24.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              languageName,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppTheme.primaryColor,
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            page.image,
            height: 300.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 40.h),
          Text(
            page.title,
            style: AppTextStyles.heading2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            page.description,
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => _buildDotIndicator(index),
            ),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            child: AppComponents.primaryButton(
              text: _currentPage == _pages.length - 1
                  ? 'Commencer'
                  : 'Suivant',
              onPressed: () {
                if (_currentPage == _pages.length - 1) {
                  _finishOnboarding();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          if (_currentPage < _pages.length - 1) ...[
            SizedBox(height: 16.h),
            TextButton(
              onPressed: _finishOnboarding,
              child: Text(
                'Passer',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? AppTheme.primaryColor
            : AppTheme.secondaryColor,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}
