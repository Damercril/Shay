import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/enums/user_type.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final List<TextEditingController> _pinControllers =
      List.generate(4, (index) => TextEditingController());
  final List<TextEditingController> _confirmPinControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _pinFocusNodes = List.generate(4, (index) => FocusNode());
  final List<FocusNode> _confirmPinFocusNodes =
      List.generate(4, (index) => FocusNode());

  bool _isLoading = false;
  UserType _selectedUserType = UserType.client;

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
      _confirmPinControllers[i].addListener(() {
        if (_confirmPinControllers[i].text.length == 1 && i < 3) {
          _confirmPinFocusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    for (var controller in [..._pinControllers, ..._confirmPinControllers]) {
      controller.dispose();
    }
    for (var node in [..._pinFocusNodes, ..._confirmPinFocusNodes]) {
      node.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  String get _pin => _pinControllers.map((c) => c.text).join();
  String get _confirmPin => _confirmPinControllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inscription',
          style: AppTextStyles.heading3,
        ),
        centerTitle: true,
      ),
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
                    SizedBox(height: 24.h),
                    Text(
                      'Créez votre compte',
                      style: AppTextStyles.heading2,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Remplissez les informations ci-dessous',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppTheme.subtitleColor,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    _buildUserTypeSelector(),
                    SizedBox(height: 24.h),
                    AppComponents.textField(
                      label: 'Nom complet',
                      controller: _nameController,
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
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
                    Text(
                      'Créez votre code PIN (4 chiffres)',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Confirmez votre code PIN',
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
                            controller: _confirmPinControllers[index],
                            focusNode: _confirmPinFocusNodes[index],
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      child: AppComponents.primaryButton(
                        text: 'S\'inscrire',
                        onPressed: _handleRegister,
                        isLoading: _isLoading,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Déjà un compte ?',
                          style: AppTextStyles.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Se connecter',
                            style: AppTextStyles.link,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildUserTypeButton(
              title: 'Client',
              type: UserType.client,
              icon: Icons.person_outline,
            ),
          ),
          Container(
            width: 1,
            height: 40.h,
            color: AppTheme.dividerColor,
          ),
          Expanded(
            child: _buildUserTypeButton(
              title: 'Professionnel',
              type: UserType.professional,
              icon: Icons.business_center_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTypeButton({
    required String title,
    required UserType type,
    required IconData icon,
  }) {
    final isSelected = _selectedUserType == type;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedUserType = type;
        });
      },
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryColor : AppTheme.subtitleColor,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isSelected ? AppTheme.primaryColor : AppTheme.subtitleColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (_pin.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un code PIN à 4 chiffres'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (_pin != _confirmPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Les codes PIN ne correspondent pas'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<AuthProvider>().register(
            _phoneController.text,
            _pin,
            _selectedUserType,
          );

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur d\'inscription: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
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
