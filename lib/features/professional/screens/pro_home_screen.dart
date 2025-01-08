import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

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
          children: [
            _buildHomeTab(),
            _buildAppointmentsTab(),
            _buildDashboardTab(),
            _buildServicesTab(),
            _buildProfileTab(),
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
            setState(() => _selectedIndex = 2); // Index du dashboard
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
                  SizedBox(width: 56.w), // Espace pour le bouton central
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

  Widget _buildHomeTab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bonjour,',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Bienvenue dans votre espace',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppTheme.subtitleColor,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.logout_rounded,
                  color: AppTheme.subtitleColor,
                  size: 24.sp,
                ),
                onPressed: () {
                  context.read<AuthProvider>().logout();
                  context.go('/login');
                },
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // Contenu de l'écran d'accueil à venir
        ],
      ),
    );
  }

  Widget _buildAppointmentsTab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mes Rendez-vous',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 24.h),
          Center(
            child: Text(
              'Liste des rendez-vous à venir',
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

  Widget _buildDashboardTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tableau de bord',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Statistiques et analyses à venir',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppTheme.subtitleColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mes Services',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 24.h),
          Center(
            child: Text(
              'Liste des services proposés',
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

  Widget _buildProfileTab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mon Profil',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 24.h),
          Center(
            child: Text(
              'Contenu du profil à venir',
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
