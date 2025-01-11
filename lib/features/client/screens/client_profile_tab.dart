import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';

class ClientProfileTab extends StatelessWidget {
  const ClientProfileTab({super.key});

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
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
      ),
      onTap: onTap,
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
            Container(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
                    ),
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
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey[200]),
            _buildProfileOption(
              icon: Icons.person_outline,
              title: 'Informations personnelles',
              subtitle: 'Nom, prénom, email, téléphone',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.favorite_border,
              title: 'Favoris',
              subtitle: '12 professionnels',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.payment,
              title: 'Moyens de paiement',
              subtitle: 'Gérer vos cartes',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.notifications_none,
              title: 'Notifications',
              subtitle: 'Gérer vos préférences',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.help_outline,
              title: 'Aide',
              subtitle: 'FAQ, support',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.privacy_tip_outlined,
              title: 'Confidentialité',
              subtitle: 'Politique de confidentialité',
              onTap: () {},
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextButton(
                onPressed: () {
                  // Handle logout
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  minimumSize: Size(double.infinity, 0),
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
}
