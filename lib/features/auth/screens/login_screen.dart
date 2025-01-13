import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_components.dart';
import '../../../core/enums/user_type.dart';
import '../../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final List<FocusNode> _pinFocusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _pinControllers =
      List.generate(4, (index) => TextEditingController());

  bool _isLoading = false;
  bool _showPin = false;
  bool _rememberMe = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();

    // Ajouter les listeners pour la navigation automatique du PIN
    for (var i = 0; i < 4; i++) {
      _pinControllers[i].addListener(() {
        if (_pinControllers[i].text.length == 1 && i < 3) {
          _pinFocusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  String get _fullPin {
    return _pinControllers.map((controller) => controller.text).join();
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
                      onTap: () => _showLanguageDialog(context, localeProvider),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 60.h),
                          Text(
                            'Bienvenue',
                            style: AppTextStyles.heading1,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppLocalizations.of(context)!.loginToContinue,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppTheme.subtitleColor,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          if (!_showPin) ...[
                            AppComponents.textField(
                              label: 'Numéro de téléphone',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone_outlined),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre numéro de téléphone';
                                }
                                if (value.length != 10) {
                                  return 'Le numéro doit contenir 10 chiffres';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                  activeColor: AppTheme.primaryColor,
                                ),
                                Text(
                                  'Se souvenir de moi',
                                  style: AppTextStyles.bodyMedium,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              width: double.infinity,
                              child: AppComponents.primaryButton(
                                text: 'Continuer',
                                onPressed: _handlePhoneSubmit,
                                isLoading: _isLoading,
                              ),
                            ),
                          ] else ...[
                            Text(
                              'Entrez votre code PIN',
                              style: AppTextStyles.bodyLarge,
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                4,
                                (index) => SizedBox(
                                  width: 50.w,
                                  child: TextFormField(
                                    controller: _pinControllers[index],
                                    focusNode: _pinFocusNodes[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          AppTheme.borderRadiusMedium,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    onChanged: (value) {
                                      if (value.isEmpty && index > 0) {
                                        _pinFocusNodes[index - 1].requestFocus();
                                      }
                                      if (_fullPin.length == 4) {
                                        _handleLogin();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(
                              width: double.infinity,
                              child: AppComponents.primaryButton(
                                text: 'Se connecter',
                                onPressed: _handleLogin,
                                isLoading: _isLoading,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _showPin = false;
                                  for (var controller in _pinControllers) {
                                    controller.clear();
                                  }
                                });
                              },
                              child: Text(
                                'Modifier le numéro',
                                style: AppTextStyles.link,
                              ),
                            ),
                          ],
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pas encore de compte ?',
                                style: AppTextStyles.bodyMedium,
                              ),
                              TextButton(
                                onPressed: () {
                                  context.go('/register');
                                },
                                child: Text(
                                  'S\'inscrire',
                                  style: AppTextStyles.link,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
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

  void _handlePhoneSubmit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _showPin = true;
      _pinFocusNodes[0].requestFocus();
    });
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (!_showPin) {
        setState(() {
          _showPin = true;
        });
      } else {
        await authProvider.loginWithPhone(
          _phoneController.text,
          _fullPin,
          rememberMe: _rememberMe,
        );

        if (!mounted) return;

        if (authProvider.userType == UserType.professional) {
          context.go('/professional');
        } else {
          context.go('/client');
        }
      }
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de connexion: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
