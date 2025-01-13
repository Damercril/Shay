import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shayniss/core/theme/app_text_styles.dart';
import 'package:shayniss/core/theme/app_theme.dart';
import 'package:shayniss/core/enums/user_type.dart';
import 'package:shayniss/core/providers/auth_provider.dart';

class ClientRegisterScreen extends StatefulWidget {
  const ClientRegisterScreen({Key? key}) : super(key: key);

  @override
  State<ClientRegisterScreen> createState() => _ClientRegisterScreenState();
}

class _ClientRegisterScreenState extends State<ClientRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _referralCodeController = TextEditingController();
  String? _selectedGender = 'F';
  bool _allowPhotos = true;
  bool _allowNotifications = true;
  bool _isLoading = false;

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool? enabled,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        enabled: enabled,
        onTap: onTap,
        style: AppTextStyles.bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppTheme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          floatingLabelStyle: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6B8EFF).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // En-tête
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/register'),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Inscription Client',
                        style: AppTextStyles.heading3.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 48.w),
                  ],
                ),
              ),
              // Formulaire
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),
                        Text(
                          'Créez votre compte',
                          style: AppTextStyles.heading2.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Entrez vos informations pour commencer',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 32.h),
                        _buildInputField(
                          label: 'Nom complet',
                          controller: _nameController,
                          icon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                        ),
                        _buildInputField(
                          label: 'Téléphone',
                          controller: _phoneController,
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre numéro de téléphone';
                            }
                            return null;
                          },
                        ),
                        _buildInputField(
                          label: 'Email',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre email';
                            }
                            if (!value.contains('@')) {
                              return 'Veuillez entrer un email valide';
                            }
                            return null;
                          },
                        ),
                        _buildInputField(
                          label: 'Date de naissance',
                          controller: _birthDateController,
                          icon: Icons.calendar_today_outlined,
                          enabled: false,
                          onTap: _selectDate,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _selectedGender,
                            decoration: InputDecoration(
                              labelText: 'Genre',
                              prefixIcon: Icon(Icons.person_outline, color: AppTheme.primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                              floatingLabelStyle: TextStyle(color: AppTheme.primaryColor),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'F',
                                child: Text('Femme'),
                              ),
                              DropdownMenuItem(
                                value: 'M',
                                child: Text('Homme'),
                              ),
                              DropdownMenuItem(
                                value: 'O',
                                child: Text('Autre'),
                              ),
                              DropdownMenuItem(
                                value: 'N',
                                child: Text('Je préfère ne pas préciser'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                        _buildInputField(
                          label: 'Adresse',
                          controller: _addressController,
                          icon: Icons.location_on_outlined,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SwitchListTile(
                                title: Text('Autoriser l\'utilisation des photos'),
                                subtitle: Text('Permettre aux professionnels de prendre des photos de vos coiffures'),
                                value: _allowPhotos,
                                onChanged: (value) {
                                  setState(() {
                                    _allowPhotos = value;
                                  });
                                },
                              ),
                              SwitchListTile(
                                title: Text('Recevoir des notifications'),
                                subtitle: Text('Restez informé des nouveautés et des offres spéciales'),
                                value: _allowNotifications,
                                onChanged: (value) {
                                  setState(() {
                                    _allowNotifications = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        _buildInputField(
                          label: 'Code de parrainage',
                          controller: _referralCodeController,
                          icon: Icons.card_giftcard_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Bouton
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => _isLoading = true);
                        try {
                          final authProvider = context.read<AuthProvider>();
                          await authProvider.register(
                            _phoneController.text,
                            '',
                            userType: UserType.client,
                          );
                          context.go('/client');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        } finally {
                          setState(() => _isLoading = false);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'S\'inscrire',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
