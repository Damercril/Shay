import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class ProReviewsTab extends StatefulWidget {
  const ProReviewsTab({super.key});

  @override
  State<ProReviewsTab> createState() => _ProReviewsTabState();
}

class _ProReviewsTabState extends State<ProReviewsTab> {
  final List<Map<String, dynamic>> reviews = [
    {
      'clientName': 'Sophie Martin',
      'rating': 5.0,
      'comment': 'Excellent service, très professionnelle et à l\'écoute !',
      'date': '2024-01-05',
      'service': 'Coiffure',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'response': 'Merci beaucoup Sophie ! C\'est toujours un plaisir de vous recevoir.',
    },
    {
      'clientName': 'Marie Dubois',
      'rating': 4.5,
      'comment': 'Très satisfaite du résultat, je recommande !',
      'date': '2024-01-03',
      'service': 'Manucure',
      'avatar': 'https://i.pravatar.cc/150?img=2',
    },
    {
      'clientName': 'Lucas Bernard',
      'rating': 5.0,
      'comment': 'Super expérience, très bon accueil et résultat parfait.',
      'date': '2024-01-02',
      'service': 'Coiffure',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'response': 'Merci Lucas ! Au plaisir de vous revoir bientôt.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double averageRating = reviews.fold(0.0, (sum, review) => sum + (review['rating'] as double)) / reviews.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor,
                AppTheme.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
        title: Text(
          'Avis Clients',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 8,
        shadowColor: AppTheme.primaryColor.withOpacity(0.5),
      ),
      body: Column(
        children: [
          _buildReviewsOverview(averageRating),
          Expanded(
            child: _buildReviewsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsOverview(double averageRating) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.primaryColor.withOpacity(0.8),
                      ],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < averageRating.floor()
                        ? Icons.star
                        : index < averageRating
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.amber,
                    size: 24.sp,
                  );
                }),
              ),
              SizedBox(height: 8.h),
              Text(
                '${reviews.length} avis',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          _buildRatingDistribution(),
        ],
      ),
    );
  }

  Widget _buildRatingDistribution() {
    Map<int, int> distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in reviews) {
      int rating = review['rating'].floor();
      distribution[rating] = (distribution[rating] ?? 0) + 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(5, (index) {
        final rating = 5 - index;
        final count = distribution[rating] ?? 0;
        final percentage = (count / reviews.length) * 100;

        return Row(
          children: [
            Text(
              '$rating',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: Colors.amber, size: 14.sp),
            SizedBox(width: 8.w),
            Container(
              width: 100.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.primaryColor.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '${percentage.toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildReviewsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(review['avatar']),
                ),
                title: Row(
                  children: [
                    Text(
                      review['clientName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      review['date'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < review['rating']
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 16.sp,
                      );
                    }),
                    SizedBox(width: 8.w),
                    Text(
                      review['service'],
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  review['comment'],
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
              if (review['response'] != null)
                Container(
                  margin: EdgeInsets.all(16.w),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Votre réponse:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        review['response'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
