import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../appointment/screens/appointment_form_screen.dart';
import '../../reviews/models/review.dart';
import '../models/professional.dart';

class ProfessionalProfileScreen extends StatefulWidget {
  final Professional professional;
  final int initialTabIndex;

  const ProfessionalProfileScreen({
    super.key,
    required this.professional,
    this.initialTabIndex = 0,
  });

  @override
  State<ProfessionalProfileScreen> createState() => _ProfessionalProfileScreenState();
}

class _ProfessionalProfileScreenState extends State<ProfessionalProfileScreen> with SingleTickerProviderStateMixin {
  final double userLatitude = 48.8566;
  final double userLongitude = 2.3522;
  late TabController _tabController;
  late PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _showReviews(BuildContext context, String userName) {
    final reviews = Review.getDummyReviews();
    final averageRating = reviews.fold<double>(0, (sum, review) => sum + review.rating) / reviews.length;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note moyenne',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Text(
                              averageRating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[800],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < averageRating.floor()
                                      ? Icons.star
                                      : index < averageRating
                                          ? Icons.star_half
                                          : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20.sp,
                                );
                              }),
                            ),
                          ],
                        ),
                        Text(
                          '${reviews.length} avis',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: reviews.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16.r,
                                backgroundImage: NetworkImage(review.userImage),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.userName,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          starIndex < review.rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 14.sp,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (review.comment.isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            Text(
                              review.comment,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                          if (review.images != null && review.images!.isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            SizedBox(
                              height: 80.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: review.images!.length,
                                itemBuilder: (context, imageIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        review.images![imageIndex],
                                        width: 80.w,
                                        height: 80.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppTheme.textColor,
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    Color? iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? Colors.grey[700],
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showShareOptions(BuildContext context) {
    final String shareText = 'Découvrez ${widget.professional.name} sur Shayniss!\n\n${widget.professional.title}\n${widget.professional.description}\n\nTéléchargez l\'application Shayniss pour prendre rendez-vous!';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    icon: FontAwesomeIcons.whatsapp,
                    label: 'WhatsApp',
                    color: Color(0xFF25D366),
                    onTap: () async {
                      final whatsappUrl = Uri.parse(
                        'whatsapp://send?text=${Uri.encodeComponent(shareText)}'
                      );
                      if (await canLaunchUrl(whatsappUrl)) {
                        await launchUrl(whatsappUrl);
                      } else {
                        Share.share(shareText);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareOption(
                    icon: FontAwesomeIcons.facebook,
                    label: 'Facebook',
                    color: Color(0xFF1877F2),
                    onTap: () async {
                      final facebookUrl = Uri.parse(
                        'https://www.facebook.com/sharer/sharer.php?u=https://shayniss.com&quote=${Uri.encodeComponent(shareText)}'
                      );
                      if (await canLaunchUrl(facebookUrl)) {
                        await launchUrl(facebookUrl);
                      } else {
                        Share.share(shareText);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareOption(
                    icon: Icons.copy,
                    label: 'Copier',
                    color: Colors.grey[700]!,
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: shareText));
                      Navigator.pop(context);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Le texte a été copié dans le presse-papier'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _buildShareOption(
                    icon: Icons.more_horiz,
                    label: 'Plus',
                    color: Colors.grey[700]!,
                    onTap: () async {
                      Navigator.pop(context);
                      await Share.share(shareText);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 64.w,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.professional.name,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share(
                'Découvrez ${widget.professional.name} sur Shayniss!\n'
                '${widget.professional.title}\n'
                'Téléchargez l\'application pour prendre rendez-vous.',
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: NetworkImage(widget.professional.profileImage),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.professional.name,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.professional.title,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.person_outline,
                          title: 'Clients',
                          value: '${widget.professional.clientsCount}+',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.star,
                          title: 'Note',
                          value: '4.8 (127 avis)',
                          iconColor: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  _buildSectionTitle('Services et tarifs'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.professional.services.length,
                    itemBuilder: (context, index) {
                      final service = widget.professional.services[index];
                      final price = widget.professional.servicesPrices[service];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              service,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppTheme.textColor,
                              ),
                            ),
                            Text(
                              '${price?.toStringAsFixed(0)}€',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  _buildSectionTitle('Spécialités'),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: widget.professional.specialties.map((specialty) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          specialty,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  _buildSectionTitle('Localisation'),
                  _buildInfoCard(
                    icon: Icons.location_on_outlined,
                    title: 'Adresse',
                    value: widget.professional.address,
                  ),
                  _buildSectionTitle('Galerie'),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                    ),
                    itemCount: widget.professional.portfolioImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                backgroundColor: Colors.black,
                                body: Stack(
                                  children: [
                                    Center(
                                      child: InteractiveViewer(
                                        minScale: 0.5,
                                        maxScale: 4.0,
                                        child: Hero(
                                          tag: 'gallery_${widget.professional.id}_$index',
                                          child: Image.network(
                                            widget.professional.portfolioImages[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 40.h,
                                      right: 16.w,
                                      child: IconButton(
                                        icon: Icon(Icons.close, color: Colors.white),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'gallery_${widget.professional.id}_$index',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                widget.professional.portfolioImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildSectionTitle('Réseaux sociaux'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.professional.socialMedia['instagram'] != null)
                        IconButton(
                          icon: Icon(FontAwesomeIcons.instagram),
                          onPressed: () async {
                            final url = 'https://instagram.com/${widget.professional.socialMedia['instagram']!.replaceAll('@', '')}';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            }
                          },
                        ),
                      if (widget.professional.socialMedia['facebook'] != null)
                        IconButton(
                          icon: Icon(FontAwesomeIcons.facebook),
                          onPressed: () async {
                            final url = 'https://facebook.com/${widget.professional.socialMedia['facebook']}';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            }
                          },
                        ),
                      if (widget.professional.socialMedia['tiktok'] != null)
                        IconButton(
                          icon: Icon(FontAwesomeIcons.tiktok),
                          onPressed: () async {
                            final url = 'https://tiktok.com/${widget.professional.socialMedia['tiktok']!.replaceAll('@', '')}';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            }
                          },
                        ),
                    ],
                  ),
                  _buildSectionTitle('Informations pratiques'),
                  Column(
                    children: [
                      _buildInfoCard(
                        icon: Icons.school_outlined,
                        title: 'Formation',
                        value: widget.professional.education,
                      ),
                      SizedBox(height: 12.h),
                      _buildInfoCard(
                        icon: Icons.work_outline,
                        title: 'Expérience',
                        value: widget.professional.experience,
                      ),
                      SizedBox(height: 12.h),
                      _buildInfoCard(
                        icon: Icons.language,
                        title: 'Langues',
                        value: widget.professional.languages.join(', '),
                      ),
                      SizedBox(height: 12.h),
                      _buildInfoCard(
                        icon: Icons.payment,
                        title: 'Moyens de paiement',
                        value: widget.professional.paymentMethods.join(', '),
                      ),
                      SizedBox(height: 12.h),
                      _buildInfoCard(
                        icon: Icons.access_time,
                        title: 'Disponibilités',
                        value: widget.professional.availability,
                      ),
                    ],
                  ),
                  SizedBox(height: 100.h), // Espace pour le bouton flottant
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentFormScreen(
                professional: widget.professional,
              ),
            ),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        label: Text(
          'Prendre rendez-vous',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: Icon(Icons.calendar_today),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
