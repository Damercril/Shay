import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import 'profile/personal_info_screen.dart';
import 'profile/addresses_screen.dart';
import 'profile/payment_methods_screen.dart';
import 'profile/security_screen.dart';
import 'profile/language_screen.dart';
import 'profile/help_support_screen.dart';
import 'profile/favorites_screen.dart';
import 'profile/notifications_screen.dart';

class ClientProfileTab extends StatelessWidget {
  const ClientProfileTab({super.key});

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
    bool showDivider = true,
    Color? iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(icon, color: iconColor ?? AppTheme.primaryColor, size: 24.w),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                )
              : null,
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
            size: 24.w,
          ),
          onTap: onTap,
        ),
        if (showDivider) Divider(height: 1, color: Colors.grey[200]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mon profil',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Marie Dupont',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'marie.dupont@email.com',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('Rendez-vous', '8'),
                      _buildStatItem('Favoris', '12'),
                      _buildStatItem('Avis', '5'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            
            // Account Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(
                      'Compte',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  _buildProfileOption(
                    icon: Icons.person_outline,
                    title: 'Informations personnelles',
                    subtitle: 'Nom, prénom, email, téléphone',
                    onTap: () {
                      context.push('/client/personal-info');
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.location_on_outlined,
                    title: 'Mes adresses',
                    subtitle: 'Gérer vos adresses',
                    onTap: () {
                      context.push('/client/addresses');
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.payment_outlined,
                    title: 'Moyens de paiement',
                    subtitle: 'Gérer vos cartes',
                    onTap: () {
                      context.push('/client/payment-methods');
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.security_outlined,
                    title: 'Sécurité',
                    subtitle: 'Mot de passe, authentification',
                    onTap: () {
                      context.push('/client/security');
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Preferences Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(
                      'Préférences',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  _buildProfileOption(
                    icon: Icons.favorite_border,
                    title: 'Favoris',
                    subtitle: '12 professionnels',
                    onTap: () {
                      context.push('/client/favorites');
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    subtitle: 'Gérer vos préférences',
                    onTap: () {
                      context.push('/client/notifications');
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.language_outlined,
                    title: 'Langue',
                    subtitle: 'Français',
                    onTap: () {
                      context.push('/client/language');
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Support Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  _buildProfileOption(
                    icon: Icons.help_outline,
                    title: 'Aide',
                    subtitle: 'FAQ, support',
                    onTap: () {
                      context.push('/client/help-support');
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Confidentialité',
                    subtitle: 'Politique de confidentialité',
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    icon: Icons.info_outline,
                    title: 'À propos',
                    subtitle: 'Version 1.0.0',
                    onTap: () {},
                    showDivider: false,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Logout Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextButton(
                onPressed: () {
                  // Handle logout
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Se déconnecter'),
                      content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () {
                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                            authProvider.logout();
                            Navigator.pop(context);
                            // Redirect to login screen using GoRouter
                            GoRouter.of(context).go('/login');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          child: const Text('Se déconnecter'),
                        ),
                      ],
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  minimumSize: Size(double.infinity, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
                child: Text(
                  'Se déconnecter',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
