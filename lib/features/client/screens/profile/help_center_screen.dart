import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  Widget _buildHelpCategory({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard({
    required String title,
    required String category,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Centre d\'aide',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Show search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: EdgeInsets.all(16.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher dans l\'aide',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),

            // Categories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Catégories',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  _buildHelpCategory(
                    title: 'Réservations',
                    description: 'Gérer vos rendez-vous',
                    icon: Icons.calendar_today,
                    onTap: () {
                      // Navigate to bookings help
                    },
                  ),
                  _buildHelpCategory(
                    title: 'Paiements',
                    description: 'Moyens de paiement et factures',
                    icon: Icons.payment,
                    onTap: () {
                      // Navigate to payments help
                    },
                  ),
                  _buildHelpCategory(
                    title: 'Compte',
                    description: 'Paramètres et sécurité',
                    icon: Icons.person,
                    onTap: () {
                      // Navigate to account help
                    },
                  ),
                  _buildHelpCategory(
                    title: 'Services',
                    description: 'Types de services et tarifs',
                    icon: Icons.spa,
                    onTap: () {
                      // Navigate to services help
                    },
                  ),
                ],
              ),
            ),

            // Popular articles
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Articles populaires',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  _buildArticleCard(
                    title: 'Comment annuler un rendez-vous ?',
                    category: 'Réservations',
                    onTap: () {
                      // Navigate to article
                    },
                  ),
                  _buildArticleCard(
                    title: 'Modes de paiement acceptés',
                    category: 'Paiements',
                    onTap: () {
                      // Navigate to article
                    },
                  ),
                  _buildArticleCard(
                    title: 'Changer mon mot de passe',
                    category: 'Compte',
                    onTap: () {
                      // Navigate to article
                    },
                  ),
                  _buildArticleCard(
                    title: 'Politique d\'annulation',
                    category: 'Réservations',
                    onTap: () {
                      // Navigate to article
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
