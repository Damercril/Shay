import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';
import 'pro_home_tab.dart';
import 'pro_appointments_tab.dart';
import 'pro_dashboard_tab.dart';
import 'pro_services_tab.dart';
import 'pro_profile_tab.dart';

class ProHomeScreen extends StatefulWidget {
  const ProHomeScreen({super.key});

  @override
  State<ProHomeScreen> createState() => _ProHomeScreenState();
}

class _ProHomeScreenState extends State<ProHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.message_rounded,
                  color: AppTheme.textColor,
                  size: 24.sp,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: _buildMessagesTab(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 12.w,
                top: 12.h,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            ProHomeTab(),
            ProAppointmentsTab(),
            ProDashboardTab(),
            ProServicesTab(),
            ProProfileTab(),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 56.h,
        width: 56.h,
        margin: EdgeInsets.only(top: 25.h),
        child: FloatingActionButton(
          backgroundColor: AppTheme.primaryColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          onPressed: () {
            setState(() => _selectedIndex = 2);
          },
          child: Icon(
            Icons.dashboard_rounded,
            size: 28.sp,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: BottomAppBar(
            height: 60.h,
            elevation: 0,
            notchMargin: 6,
            padding: EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(0, Icons.home_rounded, 'Accueil'),
                  _buildNavItem(1, Icons.calendar_today_rounded, 'Mes RDV'),
                  SizedBox(width: 56.w),
                  _buildNavItem(3, Icons.design_services_rounded, 'Services'),
                  _buildNavItem(4, Icons.person_rounded, 'Profil'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryColor : AppTheme.subtitleColor,
              size: 22.sp,
            ),
            SizedBox(height: 3.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryColor : AppTheme.subtitleColor,
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesTab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Messages',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: AppTheme.subtitleColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Center(
            child: Text(
              'Aucun message pour le moment',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppTheme.subtitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
