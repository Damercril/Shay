import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';
import '../../professional/models/professional.dart';
import '../../appointment/screens/appointment_form_screen.dart';
import '../../professional/screens/professional_profile_screen.dart';
import '../models/service_type.dart';

class ServiceProvidersScreen extends StatefulWidget {
  final ServiceType service;

  const ServiceProvidersScreen({
    super.key,
    required this.service,
  });

  @override
  State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  List<Map<String, dynamic>> _providers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    final professionals = Professional.getDummyProfessionals();
    
    _providers = professionals.map((professional) => {
      'name': professional.name,
      'image': professional.profileImage,
      'rating': 4.8,
      'description': professional.title,
      'price': '${professional.servicesPrices.values.first.toStringAsFixed(0)}€',
      'professional': professional,
      'reviews': [
        {
          'userName': 'Marie L.',
          'date': '10 Jan 2024',
          'ratings': {
            'service': 5.0,
            'punctuality': 5.0,
            'price': 4.0,
            'cleanliness': 5.0,
          },
          'comment': 'Excellent service, très professionnelle !',
          'photos': [
            'https://images.unsplash.com/photo-1560869713-da86a9ec0744?w=200&h=200&fit=crop',
          ],
        },
        {
          'userName': 'Sophie R.',
          'date': '5 Jan 2024',
          'ratings': {
            'service': 5.0,
            'punctuality': 4.0,
            'price': 5.0,
            'cleanliness': 5.0,
          },
          'comment': 'Très satisfaite du résultat !',
          'photos': [],
        },
      ],
    }).toList();

    setState(() {
      _isLoading = false;
    });
  }

  void _showReviews(Map<String, dynamic> provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.only(
          top: 8.h,
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        CircleAvatar(
                          radius: 40.r,
                          backgroundImage: NetworkImage(provider['image']),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          provider['name'],
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          provider['description'],
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 24.sp),
                            SizedBox(width: 4.w),
                            Text(
                              provider['rating'].toString(),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' (${provider['reviews'].length} avis)',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        _buildRatingStats(provider['reviews']),
                        Divider(height: 32.h),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildReviewCard(provider['reviews'][index]),
                        childCount: provider['reviews'].length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStats(List<dynamic> reviews) {
    Map<String, double> averages = {
      'service': 0,
      'punctuality': 0,
      'price': 0,
      'cleanliness': 0,
    };

    for (var review in reviews) {
      var ratings = review['ratings'];
      averages.forEach((key, value) {
        averages[key] = value + ratings[key];
      });
    }

    averages.forEach((key, value) {
      averages[key] = value / reviews.length;
    });

    return Column(
      children: [
        _buildRatingBar('Service', averages['service']!),
        SizedBox(height: 8.h),
        _buildRatingBar('Ponctualité', averages['punctuality']!),
        SizedBox(height: 8.h),
        _buildRatingBar('Prix', averages['price']!),
        SizedBox(height: 8.h),
        _buildRatingBar('Propreté', averages['cleanliness']!),
      ],
    );
  }

  Widget _buildRatingBar(String label, double rating) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: rating / 5,
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review['userName'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  review['date'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: List.generate(5, (index) {
                double averageRating = review['ratings'].values.reduce((a, b) => a + b) / 4;
                return Icon(
                  index < averageRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20.sp,
                );
              }),
            ),
            if (review['comment'] != null && review['comment'].isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                review['comment'],
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
            if (review['photos'] != null && review['photos'].isNotEmpty) ...[
              SizedBox(height: 8.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: review['photos'].map<Widget>((photo) => Container(
                    width: 80.w,
                    height: 80.w,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: NetworkImage(photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showAppointmentSheet(BuildContext context, Map<String, dynamic> provider) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentFormScreen(
          professional: provider['professional'],
        ),
      ),
    );
  }

  void _showProviderProfile(Map<String, dynamic> provider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfessionalProfileScreen(
          professional: provider['professional'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prestataires',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: _providers.length,
              itemBuilder: (context, index) {
                final provider = _providers[index];
                return GestureDetector(
                  onTap: () => _showReviews(provider),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.w,
                              margin: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(provider['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider['name'],
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      provider['description'],
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 6.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 14.w,
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          provider['rating'].toString(),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.textColor,
                                          ),
                                        ),
                                        Text(
                                          ' (${provider['reviews'].length} avis)',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'À partir de ',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          provider['price'],
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (provider['professional'].portfolioImages.isNotEmpty)
                          Container(
                            height: 100.h,
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              scrollDirection: Axis.horizontal,
                              itemCount: provider['professional'].portfolioImages.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Container(
                                          width: double.infinity,
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(provider['professional'].portfolioImages[index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 100.w,
                                    margin: EdgeInsets.only(right: 8.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      image: DecorationImage(
                                        image: NetworkImage(provider['professional'].portfolioImages[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                          child: ElevatedButton(
                            onPressed: () => _showAppointmentSheet(context, provider),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Prendre RDV',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
