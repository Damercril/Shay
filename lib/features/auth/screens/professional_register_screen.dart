import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shayniss/core/enums/user_type.dart';
import 'package:shayniss/core/theme/app_text_styles.dart';
import 'package:shayniss/core/theme/app_theme.dart';
import 'package:shayniss/core/providers/auth_provider.dart';

class ServiceItem {
  final String name;
  final String imagePath;
  final String? description;

  ServiceItem({
    required this.name,
    required this.imagePath,
    this.description,
  });
}

class ProfessionalRegisterScreen extends StatefulWidget {
  const ProfessionalRegisterScreen({Key? key}) : super(key: key);

  @override
  State<ProfessionalRegisterScreen> createState() => _ProfessionalRegisterScreenState();
}

class _ProfessionalRegisterScreenState extends State<ProfessionalRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _professionController = TextEditingController();
  final _bioController = TextEditingController();
  final _socialMediaControllers = <String, TextEditingController>{
    'instagram': TextEditingController(),
    'tiktok': TextEditingController(),
    'facebook': TextEditingController(),
    'youtube': TextEditingController(),
  };

  int _currentStep = 0;
  bool _isLoading = false;
  double? _latitude;
  double? _longitude;
  bool _mobileService = false;
  bool _noFixedLocation = false;
  final List<String> _languages = ['Français'];
  final List<String> _paymentMethods = ['Espèces'];
  final List<ServiceItem> _selectedServices = [];
  bool _requiresDeposit = false;
  bool _requiresPhotoPayment = false;
  bool _requiresAppointmentConfirmation = true;

  final List<ServiceItem> _availableServices = [
    ServiceItem(
      name: 'Coiffure',
      imagePath: 'https://images.pexels.com/photos/3993444/pexels-photo-3993444.jpeg',
      description: 'Coupes, brushing, coiffures',
    ),
    ServiceItem(
      name: 'Onglerie',
      imagePath: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixlib=rb-4.0.3',
      description: 'Manucure, pédicure, pose',
    ),
    ServiceItem(
      name: 'Maquillage',
      imagePath: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixlib=rb-4.0.3',
      description: 'Maquillage jour et soirée',
    ),
    ServiceItem(
      name: 'Massage',
      imagePath: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?ixlib=rb-4.0.3',
      description: 'Relaxation et bien-être',
    ),
    ServiceItem(
      name: 'Soins du visage',
      imagePath: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixlib=rb-4.0.3',
      description: 'Nettoyage, masques, soins',
    ),
    ServiceItem(
      name: 'Épilation',
      imagePath: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixlib=rb-4.0.3',
      description: 'Visage et corps',
    ),
  ];

  final TextEditingController _newServiceController = TextEditingController();
  final List<ServiceItem> _customServices = [];

  Future<void> _showMapPicker() async {
    if (_noFixedLocation) return;
    
    final result = await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 400.h,
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Text(
                'Sélectionnez l\'emplacement de votre salon',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '🗺️ Map Placeholder\nIci sera intégrée la carte Google Maps',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.go('/register'),
                    child: Text('Annuler'),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: () {
                      // Simuler la sélection des coordonnées
                      setState(() {
                        _latitude = 48.8566;
                        _longitude = 2.3522;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Confirmer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ajouter un nouveau service',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _newServiceController,
                decoration: InputDecoration(
                  labelText: 'Nom du service',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.go('/register'),
                    child: Text('Annuler'),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: () {
                      if (_newServiceController.text.isNotEmpty) {
                        final newService = ServiceItem(
                          name: _newServiceController.text,
                          imagePath: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixlib=rb-4.0.3',
                        );
                        setState(() {
                          _customServices.add(newService);
                          _selectedServices.add(newService);
                        });
                        _newServiceController.clear();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Ajouter',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool? enabled,
    VoidCallback? onTap,
    int? maxLines,
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
        maxLines: maxLines ?? 1,
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

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations personnelles',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
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
        SizedBox(height: 16.h),
        _buildInputField(
          label: 'Numéro de téléphone',
          controller: _phoneController,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
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
        _buildInputField(
          label: 'Email professionnel',
          controller: _emailController,
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre email professionnel';
            }
            if (!value.contains('@') || !value.contains('.')) {
              return 'Veuillez entrer un email valide';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          label: 'Profession',
          controller: _professionController,
          icon: Icons.work_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre profession';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          label: 'Bio',
          controller: _bioController,
          icon: Icons.text_fields,
          maxLines: 5,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre bio';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLocationAndServicesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Localisation et services',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 24.h),
        Container(
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
                title: Text('Service à domicile'),
                subtitle: Text('Je me déplace chez les clients'),
                value: _mobileService,
                onChanged: (value) {
                  setState(() {
                    _mobileService = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Pas de salon fixe'),
                subtitle: Text('Je n\'ai pas d\'adresse professionnelle fixe'),
                value: _noFixedLocation,
                onChanged: (value) {
                  setState(() {
                    _noFixedLocation = value;
                    if (value) {
                      _latitude = null;
                      _longitude = null;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        if (!_noFixedLocation) ...[
          _buildInputField(
            label: 'Adresse du salon',
            controller: _addressController,
            icon: Icons.location_on_outlined,
            onTap: _showMapPicker,
            enabled: false,
            validator: (value) {
              if (!_noFixedLocation && (value == null || value.isEmpty)) {
                return 'Veuillez entrer l\'adresse de votre salon';
              }
              return null;
            },
          ),
          if (_latitude != null && _longitude != null)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Text(
                'Coordonnées: ${_latitude!.toStringAsFixed(6)}, ${_longitude!.toStringAsFixed(6)}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
        SizedBox(height: 24.h),
        Text(
          'Langues parlées',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          children: [
            'Français',
            'Anglais',
            'Arabe',
            'Espagnol',
          ].map((language) {
            final isSelected = _languages.contains(language);
            return FilterChip(
              label: Text(language),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _languages.add(language);
                  } else {
                    _languages.remove(language);
                  }
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 24.h),
        Text(
          'Services proposés',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: [
            ..._availableServices.map((service) => _buildServiceCard(service)),
            ..._customServices.map((service) => _buildServiceCard(service, isCustom: true)),
            GestureDetector(
              onTap: _showAddServiceDialog,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                    style: BorderStyle.none,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: AppTheme.primaryColor,
                      size: 32.sp,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Ajouter\nun service',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Text(
          'Moyens de paiement acceptés',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          children: [
            'Espèces',
            'Carte bancaire',
            'Mobile Money',
            'Virement',
          ].map((method) {
            final isSelected = _paymentMethods.contains(method);
            return FilterChip(
              label: Text(method),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _paymentMethods.add(method);
                  } else {
                    _paymentMethods.remove(method);
                  }
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 24.h),
        Container(
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
                title: Text('Réduction photos 5%'),
                subtitle: Text('J\'accorde une réduction de 5% aux clients qui acceptent que j\'utilise leurs photos'),
                value: _requiresPhotoPayment,
                onChanged: (value) {
                  setState(() {
                    _requiresPhotoPayment = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Acompte requis'),
                subtitle: Text('Je demande un acompte pour confirmer la réservation'),
                value: _requiresDeposit,
                onChanged: (value) {
                  setState(() {
                    _requiresDeposit = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Confirmation de rendez-vous'),
                subtitle: Text('Demander une confirmation au client 12h avant le rendez-vous'),
                value: _requiresAppointmentConfirmation,
                onChanged: (value) {
                  setState(() {
                    _requiresAppointmentConfirmation = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(ServiceItem service, {bool isCustom = false}) {
    final isSelected = _selectedServices.contains(service);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedServices.remove(service);
          } else {
            _selectedServices.add(service);
          }
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    service.imagePath,
                    width: double.infinity,
                    height: 120.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: ${service.imagePath}');
                      return Container(
                        width: double.infinity,
                        height: 120.h,
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getServiceIcon(service.name),
                              color: Colors.grey[400],
                              size: 32.sp,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Image non disponible',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    children: [
                      Text(
                        service.name,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (service.description != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          service.description!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            if (isCustom)
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red, size: 20),
                  onPressed: () {
                    setState(() {
                      _customServices.remove(service);
                      _selectedServices.remove(service);
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'coiffure':
        return Icons.content_cut;
      case 'onglerie':
        return Icons.spa;
      case 'maquillage':
        return Icons.face;
      case 'massage':
        return Icons.spa;
      case 'soins du visage':
        return Icons.face_retouching_natural;
      case 'épilation':
        return Icons.star;
      default:
        return Icons.spa;
    }
  }

  Widget _buildSocialMediaStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Réseaux sociaux',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          label: 'Instagram',
          controller: _socialMediaControllers['instagram']!,
          icon: Icons.camera_alt_outlined,
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          label: 'TikTok',
          controller: _socialMediaControllers['tiktok']!,
          icon: Icons.music_note_outlined,
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          label: 'Facebook',
          controller: _socialMediaControllers['facebook']!,
          icon: Icons.facebook_outlined,
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          label: 'YouTube',
          controller: _socialMediaControllers['youtube']!,
          icon: Icons.play_circle_outline,
        ),
      ],
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner au moins un service'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.register(
        _phoneController.text,
        '',
        userType: UserType.professional,
      );

      if (!mounted) return;

      context.go('/professional');
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur d\'inscription: ${e.toString()}'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription Professionnel'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/register'),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            setState(() {
              if (_currentStep < 2) {
                _currentStep++;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep--;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              _currentStep = step;
            });
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Retour',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                  if (_currentStep > 0)
                    SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _currentStep < 2 
                          ? details.onStepContinue 
                          : () => _handleRegister(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _currentStep < 2 ? 'Suivant' : 'Terminer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text('Informations personnelles'),
              content: _buildPersonalInfoStep(),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Localisation et services'),
              content: _buildLocationAndServicesStep(),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text('Réseaux sociaux'),
              content: _buildSocialMediaStep(),
              isActive: _currentStep >= 2,
            ),
          ],
        ),
      ),
    );
  }
}
