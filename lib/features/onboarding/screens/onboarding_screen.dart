import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_components.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                  // Naviguer vers l'écran de connexion
                  context.go('/login');
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
              onPressed: () {
                context.go('/login');
              },
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
