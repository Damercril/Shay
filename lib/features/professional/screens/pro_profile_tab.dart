import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/styles.dart';
import '../../../core/providers/auth_provider.dart';
import '../models/professional.dart';

class ProProfileTab extends StatefulWidget {
  const ProProfileTab({super.key});

  @override
  State<ProProfileTab> createState() => _ProProfileTabState();
}

class _ProProfileTabState extends State<ProProfileTab> {
  final ImagePicker _picker = ImagePicker();
  bool _isEditing = false;
  String? _profileImage;
  
  // Images de démonstration depuis un CDN public
  final String _defaultProfileImage = 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800';
  final List<String> _galleryImages = [
    'https://images.unsplash.com/photo-1562322140-8baeececf3df?w=800',
    'https://images.unsplash.com/photo-1596178060671-7a80dc8059ea?w=800',
    'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=800',
    'https://images.unsplash.com/photo-1565538420870-da08ff96a207?w=800',
    'https://images.unsplash.com/photo-1579187707643-35646d22b596?w=800',
    'https://images.unsplash.com/photo-1560869713-7d0a29430803?w=800',
    'https://images.unsplash.com/photo-1595476108010-b4d1f102b1b1?w=800',
    'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=800'
  ];
  
  // Informations de base
  final TextEditingController _nameController = TextEditingController(text: 'Sarah Martin');
  final TextEditingController _professionController = TextEditingController(text: 'Coiffeuse Professionnelle');
  final TextEditingController _bioController = TextEditingController(
    text: 'Passionnée par la coiffure depuis plus de 10 ans, je crée des styles uniques adaptés à chaque personnalité. Spécialisée dans les colorations et les coupes modernes.',
  );
  
  // Localisation et contact
  final TextEditingController _addressController = TextEditingController(text: '15 rue de la Paix, 75001 Paris');
  final TextEditingController _phoneController = TextEditingController(text: '+33 6 12 34 56 78');
  final TextEditingController _emailController = TextEditingController(text: 'sarah.martin@gmail.com');
  
  // Nouvelles informations
  final TextEditingController _experienceController = TextEditingController(text: '10');
  List<String> _languages = ['Français', 'Anglais', 'Espagnol'];
  bool _mobileService = true;
  List<String> _paymentMethods = [
    'Carte bancaire',
    'Espèces',
    'PayPal',
    'Apple Pay',
    'Orange Money',
    'MTN Mobile Money',
    'Wave',
    'Moov Money'
  ];
  
  // Réseaux sociaux
  final Map<String, String> _socialMedia = {
    'instagram': '@sarah.beauty',
    'tiktok': '@sarahbeauty',
    'snapchat': '@sarah_beauty',
    'facebook': 'Sarah Martin Beauty',
  };

  // Horaires d'ouverture
  final Map<String, Map<String, String>> _businessHours = {
    'Lundi': {'start': '09:00', 'end': '19:00', 'isOpen': 'true'},
    'Mardi': {'start': '09:00', 'end': '19:00', 'isOpen': 'true'},
    'Mercredi': {'start': '09:00', 'end': '19:00', 'isOpen': 'true'},
    'Jeudi': {'start': '09:00', 'end': '19:00', 'isOpen': 'true'},
    'Vendredi': {'start': '09:00', 'end': '20:00', 'isOpen': 'true'},
    'Samedi': {'start': '10:00', 'end': '18:00', 'isOpen': 'true'},
    'Dimanche': {'start': '00:00', 'end': '00:00', 'isOpen': 'false'},
  };

  // Diplômes et certifications
  final List<Map<String, String>> _certifications = [
    {
      'title': 'CAP Coiffure',
      'institution': 'École de Coiffure de Paris',
      'year': '2015',
    },
    {
      'title': 'BTS Esthétique',
      'institution': 'Institut de Beauté de Paris',
      'year': '2017',
    },
    {
      'title': 'Formation Coloration Avancée',
      'institution': 'L\'Oréal Professionnel',
      'year': '2019',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  _buildMainInfo(),
                  SizedBox(height: 16.h),
                  _buildLocationAndServices(),
                  SizedBox(height: 16.h),
                  _buildPaymentAndLanguages(),
                  SizedBox(height: 16.h),
                  _buildExperience(),
                  SizedBox(height: 16.h),
                  _buildGallerySection(),
                  SizedBox(height: 16.h),
                  _buildSocialMedia(),
                  SizedBox(height: 16.h),
                  _buildBusinessHours(),
                  SizedBox(height: 16.h),
                  _buildCertifications(),
                  SizedBox(height: 16.h),
                  _buildAccountSettings(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isEditing = !_isEditing;
          });
        },
        child: Icon(
          _isEditing ? Icons.check : Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      children: [
        Container(
          height: 200.h,
          decoration: BoxDecoration(
            gradient: Styles.headerGradient,
          ),
          child: Stack(
            children: [
              Positioned(
                top: -50.h,
                right: -30.w,
                child: Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -60.h,
                left: -40.w,
                child: Container(
                  width: 150.w,
                  height: 150.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 40.h,
          left: 20.w,
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              gradient: Styles.cardGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 60.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 57.r,
                backgroundImage: _profileImage != null
                    ? FileImage(File(_profileImage!))
                    : NetworkImage(_defaultProfileImage) as ImageProvider,
              ),
            ),
          ),
        ),
        if (_isEditing)
          Positioned(
            top: 120.h,
            left: 85.w,
            child: Styles.iconButton(
              icon: Icons.camera_alt,
              onPressed: _pickProfileImage,
              gradient: Styles.accentGradient,
              size: 40,
            ),
          ),
        Positioned(
          top: 50.h,
          left: 160.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _nameController.text,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
              Text(
                _professionController.text,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white.withOpacity(0.9),
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainInfo() {
    return Container(
      margin: EdgeInsets.only(top: 60.h),
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isEditing) ...[
            TextFormField(
              controller: _nameController,
              decoration: Styles.inputDecoration.copyWith(
                labelText: 'Nom complet',
                prefixIcon: Icon(Icons.person, color: AppTheme.primaryColor),
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _professionController,
              decoration: Styles.inputDecoration.copyWith(
                labelText: 'Profession',
                prefixIcon: Icon(Icons.work, color: AppTheme.primaryColor),
              ),
            ),
          ] else ...[
            Text(
              _nameController.text,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = Styles.headerGradient.createShader(
                  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                ),
              ),
            ),
            Text(
              _professionController.text,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
          SizedBox(height: 16.h),
          if (_isEditing)
            TextFormField(
              controller: _bioController,
              maxLines: 3,
              decoration: Styles.inputDecoration.copyWith(
                labelText: 'Bio',
                prefixIcon: Icon(Icons.description, color: AppTheme.primaryColor),
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: Styles.glassmorphicDecoration.copyWith(
                color: Colors.grey.shade50,
              ),
              child: Text(
                _bioController.text,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGallerySection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Galerie',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = Styles.headerGradient.createShader(
                    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                  ),
                ),
              ),
              if (_isEditing)
                Styles.iconButton(
                  icon: Icons.add_photo_alternate,
                  onPressed: _pickGalleryImage,
                  gradient: Styles.accentGradient,
                  size: 40,
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 300.h,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 1,
              ),
              itemCount: _galleryImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Stack(
                          children: [
                            Image.network(
                              _galleryImages[index],
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: IconButton(
                                icon: Icon(Icons.close, color: Colors.white),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(_galleryImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAndServices() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Localisation et Services',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = Styles.headerGradient.createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: Styles.glassmorphicDecoration.copyWith(
              color: Colors.grey.shade50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppTheme.primaryColor),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _isEditing
                          ? TextFormField(
                              controller: _addressController,
                              decoration: Styles.inputDecoration.copyWith(
                                labelText: 'Adresse',
                              ),
                            )
                          : Text(_addressController.text),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(Icons.directions_car, color: AppTheme.primaryColor),
                    SizedBox(width: 8.w),
                    Text('Service à domicile'),
                    Spacer(),
                    Switch(
                      value: _mobileService,
                      onChanged: _isEditing
                          ? (value) {
                              setState(() {
                                _mobileService = value;
                              });
                            }
                          : null,
                      activeColor: AppTheme.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentAndLanguages() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paiement et Langues',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = Styles.headerGradient.createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: Styles.glassmorphicDecoration.copyWith(
              color: Colors.grey.shade50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Moyens de paiement acceptés',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: _paymentMethods.map((method) {
                    IconData getPaymentIcon(String method) {
                      switch (method.toLowerCase()) {
                        case 'carte bancaire':
                          return Icons.credit_card;
                        case 'espèces':
                          return Icons.money;
                        case 'paypal':
                          return FontAwesomeIcons.paypal;
                        case 'apple pay':
                          return FontAwesomeIcons.apple;
                        case 'orange money':
                          return Icons.phone_android;
                        case 'mtn mobile money':
                          return Icons.phone_android;
                        case 'wave':
                          return Icons.waves;
                        case 'moov money':
                          return Icons.phone_android;
                        default:
                          return Icons.payment;
                      }
                    }

                    Color getPaymentColor(String method) {
                      switch (method.toLowerCase()) {
                        case 'orange money':
                          return Color(0xFFFF6600); // Orange
                        case 'mtn mobile money':
                          return Color(0xFFFFCC00); // MTN Yellow
                        case 'wave':
                          return Color(0xFF00C4CC); // Wave Blue
                        case 'moov money':
                          return Color(0xFF0066CC); // Moov Blue
                        case 'paypal':
                          return Color(0xFF003087); // PayPal Blue
                        case 'apple pay':
                          return Colors.black;
                        default:
                          return AppTheme.primaryColor.withOpacity(0.2);
                      }
                    }

                    return Chip(
                      avatar: Icon(
                        getPaymentIcon(method),
                        size: 16.sp,
                        color: getPaymentColor(method),
                      ),
                      label: Text(
                        method,
                        style: TextStyle(
                          color: getPaymentColor(method),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: getPaymentColor(method),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Langues parlées',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  children: _languages.map((language) {
                    return Chip(
                      label: Text(language),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.2)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperience() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expérience',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = Styles.headerGradient.createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: Styles.glassmorphicDecoration.copyWith(
              color: Colors.grey.shade50,
            ),
            child: Row(
              children: [
                Icon(Icons.work_history, color: AppTheme.primaryColor),
                SizedBox(width: 8.w),
                Expanded(
                  child: _isEditing
                      ? TextFormField(
                          controller: _experienceController,
                          keyboardType: TextInputType.number,
                          decoration: Styles.inputDecoration.copyWith(
                            labelText: 'Années d\'expérience',
                            suffixText: 'ans',
                          ),
                        )
                      : Text(
                          '${_experienceController.text} ans d\'expérience',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMedia() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Réseaux sociaux',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = Styles.headerGradient.createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: Styles.glassmorphicDecoration.copyWith(
              color: Colors.grey.shade50,
            ),
            child: Column(
              children: [
                _buildSocialMediaItem(
                  icon: FontAwesomeIcons.instagram,
                  title: 'Instagram',
                  value: _socialMedia['instagram']!,
                  color: Color(0xFFE1306C),
                ),
                Divider(height: 16.h),
                _buildSocialMediaItem(
                  icon: FontAwesomeIcons.tiktok,
                  title: 'TikTok',
                  value: _socialMedia['tiktok']!,
                  color: Colors.black,
                ),
                Divider(height: 16.h),
                _buildSocialMediaItem(
                  icon: FontAwesomeIcons.snapchat,
                  title: 'Snapchat',
                  value: _socialMedia['snapchat']!,
                  color: Color(0xFFFFFC00),
                ),
                Divider(height: 16.h),
                _buildSocialMediaItem(
                  icon: FontAwesomeIcons.facebook,
                  title: 'Facebook',
                  value: _socialMedia['facebook']!,
                  color: Color(0xFF1877F2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(width: 12.w),
        if (_isEditing)
          Expanded(
            child: TextFormField(
              initialValue: value,
              decoration: Styles.inputDecoration.copyWith(
                labelText: title,
              ),
            ),
          )
        else
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBusinessHours() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horaires d\'ouverture',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = Styles.headerGradient.createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          ...(_businessHours.entries.map((entry) {
            return Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(12.w),
              decoration: Styles.glassmorphicDecoration.copyWith(
                color: Colors.grey.shade50,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (_isEditing) ...[
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: entry.value['start'],
                              decoration: Styles.inputDecoration.copyWith(
                                labelText: 'Début',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: TextFormField(
                              initialValue: entry.value['end'],
                              decoration: Styles.inputDecoration.copyWith(
                                labelText: 'Fin',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                              ),
                            ),
                          ),
                          Switch(
                            value: entry.value['isOpen'] == 'true',
                            onChanged: (value) {
                              setState(() {
                                _businessHours[entry.key]!['isOpen'] =
                                    value.toString();
                              });
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ] else
                    Expanded(
                      child: Text(
                        entry.value['isOpen'] == 'true'
                            ? '${entry.value['start']} - ${entry.value['end']}'
                            : 'Fermé',
                        style: TextStyle(
                          color: entry.value['isOpen'] == 'true'
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList()),
        ],
      ),
    );
  }

  Widget _buildCertifications() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Diplômes et certifications',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = Styles.headerGradient.createShader(
                    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                  ),
                ),
              ),
              if (_isEditing)
                Container(
                  decoration: BoxDecoration(
                    gradient: Styles.accentGradient,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: _addCertification,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          ..._certifications.map((cert) {
            return Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(12.w),
              decoration: Styles.glassmorphicDecoration.copyWith(
                color: Colors.grey.shade50,
              ),
              child: _isEditing
                  ? Column(
                      children: [
                        TextFormField(
                          initialValue: cert['title'],
                          decoration: Styles.inputDecoration.copyWith(
                            labelText: 'Titre',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          initialValue: cert['institution'],
                          decoration: Styles.inputDecoration.copyWith(
                            labelText: 'Institution',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          initialValue: cert['year'],
                          decoration: Styles.inputDecoration.copyWith(
                            labelText: 'Année',
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cert['title']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          cert['institution']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          cert['year']!,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: Styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paramètres du compte',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = Styles.headerGradient.createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: Styles.glassmorphicDecoration.copyWith(
              color: Colors.grey.shade50,
            ),
            child: Column(
              children: [
                _buildSettingItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {},
                ),
                Divider(height: 1),
                _buildSettingItem(
                  icon: Icons.lock,
                  title: 'Confidentialité',
                  onTap: () {},
                ),
                Divider(height: 1),
                _buildSettingItem(
                  icon: Icons.help,
                  title: 'Aide et support',
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Center(
            child: Styles.gradientButton(
              text: 'Se déconnecter',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Déconnexion'),
                    content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          final authProvider = context.read<AuthProvider>();
                          authProvider.logout();
                          context.go('/login');
                        },
                        child: Text(
                          'Se déconnecter',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              gradient: Styles.warningGradient,
              icon: Icons.logout,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppTheme.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Future<void> _pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _profileImage = image.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la sélection de l\'image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickGalleryImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _galleryImages.add(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la sélection de l\'image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _addCertification() {
    setState(() {
      _certifications.add({
        'title': '',
        'institution': '',
        'year': '',
      });
    });
  }
}
