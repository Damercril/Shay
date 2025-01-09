import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class ProServicesTab extends StatelessWidget {
  const ProServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mes Services',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle_rounded,
                    color: AppTheme.primaryColor,
                    size: 32.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildServiceCard();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.r),
              ),
              color: AppTheme.primaryColor.withOpacity(0.1),
            ),
            child: Center(
              child: Icon(
                Icons.image_rounded,
                size: 48.sp,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Coupe + Barbe',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    Text(
                      '35€',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Coupe de cheveux et taille de barbe avec finitions soignées',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.subtitleColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    _buildServiceDetail(
                      icon: Icons.timer_rounded,
                      text: '45min',
                    ),
                    SizedBox(width: 24.w),
                    _buildServiceDetail(
                      icon: Icons.star_rounded,
                      text: '4.8 (124)',
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text('Modifier'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 24.sp,
                      ),
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

  Widget _buildServiceDetail({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: AppTheme.subtitleColor,
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppTheme.subtitleColor,
          ),
        ),
      ],
    );
  }
}
