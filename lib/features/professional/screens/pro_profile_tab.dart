import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class ProProfileTab extends StatelessWidget {
  const ProProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildProfileInfo(),
                SizedBox(height: 24.h),
                _buildMenuSection(),
                SizedBox(height: 24.h),
                _buildBusinessHours(),
                SizedBox(height: 24.h),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person_rounded,
                size: 50.sp,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Barbier professionnel',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.phone_rounded,
            title: 'Téléphone',
            value: '+33 6 12 34 56 78',
          ),
          Divider(height: 24.h),
          _buildInfoRow(
            icon: Icons.email_rounded,
            title: 'Email',
            value: 'john.doe@example.com',
          ),
          Divider(height: 24.h),
          _buildInfoRow(
            icon: Icons.location_on_rounded,
            title: 'Adresse',
            value: '123 Rue du Commerce, Paris',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppTheme.subtitleColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.edit_rounded,
            color: AppTheme.primaryColor,
            size: 20.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Container(
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
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.settings_rounded,
            title: 'Paramètres',
            onTap: () {},
          ),
          Divider(height: 1.h),
          _buildMenuItem(
            icon: Icons.notifications_rounded,
            title: 'Notifications',
            onTap: () {},
          ),
          Divider(height: 1.h),
          _buildMenuItem(
            icon: Icons.help_outline_rounded,
            title: 'Aide',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppTheme.textColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppTheme.subtitleColor,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessHours() {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Horaires d\'ouverture',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit_rounded,
                  color: AppTheme.primaryColor,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildHourRow('Lundi', '09:00 - 19:00'),
          _buildHourRow('Mardi', '09:00 - 19:00'),
          _buildHourRow('Mercredi', '09:00 - 19:00'),
          _buildHourRow('Jeudi', '09:00 - 19:00'),
          _buildHourRow('Vendredi', '09:00 - 19:00'),
          _buildHourRow('Samedi', '10:00 - 17:00'),
          _buildHourRow('Dimanche', 'Fermé'),
        ],
      ),
    );
  }

  Widget _buildHourRow(String day, String hours) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppTheme.textColor,
            ),
          ),
          Text(
            hours,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Logique de déconnexion
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Se déconnecter',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
