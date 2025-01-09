import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shayniss/core/theme/app_theme.dart';
import 'package:shayniss/features/professional/models/professional.dart';
import 'package:shayniss/features/professional/screens/professional_profile_screen.dart';

class ProfessionalsListScreen extends StatelessWidget {
  final String serviceType;
  final List<Professional> professionals;
  // Position simulée de l'utilisateur (Paris centre)
  final double userLatitude = 48.8566;
  final double userLongitude = 2.3522;

  const ProfessionalsListScreen({
    super.key,
    required this.serviceType,
    required this.professionals,
  });

  @override
  Widget build(BuildContext context) {
    final filteredProfessionals = professionals
        .where((p) => p.services.contains(serviceType))
        .toList()
      ..sort((a, b) => a.getDistanceFrom(userLatitude, userLongitude)
          .compareTo(b.getDistanceFrom(userLatitude, userLongitude)));

    return Scaffold(
      appBar: AppBar(
        title: Text(serviceType),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        itemCount: filteredProfessionals.length,
        itemBuilder: (context, index) {
          final professional = filteredProfessionals[index];
          final distance = professional.getDistanceFrom(userLatitude, userLongitude);
          
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfessionalProfileScreen(
                      professional: professional,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    if (professional.imageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          professional.imageUrl!,
                          width: 80.w,
                          height: 80.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  professional.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppTheme.primaryColor,
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '${distance.toStringAsFixed(1)} km',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            professional.description,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16.sp),
                              SizedBox(width: 4.w),
                              Text(
                                '${professional.rating}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' (${professional.reviewCount})',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                professional.location,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
