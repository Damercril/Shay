import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_components.dart';
import '../../../core/enums/user_type.dart';

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
                      'Connectez-vous pour continuer',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppTheme.subtitleColor,
                      ),
                    ),
                    SizedBox(height: 48.h),
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
                      SizedBox(height: 24.h),
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
    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = context.read<AuthProvider>();
      await authProvider.loginWithPhone(
        _phoneController.text,
        _fullPin,
      );

      if (!mounted) return;
      
      if (authProvider.userType == UserType.professional) {
        context.go('/professional');
      } else {
        context.go('/client');
      }
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de connexion. Veuillez réessayer.'),
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
