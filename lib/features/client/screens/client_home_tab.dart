import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../models/service_type.dart';
import '../screens/service_providers_screen.dart';
import '../../appointment/screens/appointment_form_screen.dart';
import '../../professional/models/professional.dart';
import '../../professional/screens/professional_profile_screen.dart';

class ClientHomeTab extends StatefulWidget {
  const ClientHomeTab({super.key});

  @override
  State<ClientHomeTab> createState() => _ClientHomeTabState();
}

class _ClientHomeTabState extends State<ClientHomeTab> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  final List<Professional> _professionals = Professional.getDummyProfessionals();
  final Map<String, bool> _likedPosts = {};
  final Map<String, int> _likesCount = {};
  final Map<String, int> _commentsCount = {};

  static const List<ServiceType> serviceTypes = [
    ServiceType(
      name: 'Coiffure',
      icon: FontAwesomeIcons.scissors,
      keywords: ['coiffure', 'cheveux', 'coupe'],
      colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
      imageUrl: 'https://images.unsplash.com/photo-1595476108010-b4d1f102b1b1?w=500&h=500&fit=crop',
    ),
    ServiceType(
      name: 'Manucure',
      icon: FontAwesomeIcons.handSparkles,
      keywords: ['manucure', 'ongles', 'nail'],
      colors: [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
      imageUrl: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=500&h=500&fit=crop',
    ),
    ServiceType(
      name: 'Soin',
      icon: FontAwesomeIcons.spa,
      keywords: ['soin', 'visage', 'facial'],
      colors: [Color(0xFF96E6A1), Color(0xFFD4FC79)],
      imageUrl: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=500&h=500&fit=crop',
    ),
    ServiceType(
      name: 'Massage',
      icon: FontAwesomeIcons.handHoldingHeart,
      keywords: ['massage', 'détente'],
      colors: [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
      imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=500&h=500&fit=crop',
    ),
    ServiceType(
      name: 'Maquillage',
      icon: FontAwesomeIcons.wandMagicSparkles,
      keywords: ['maquillage', 'makeup'],
      colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
      imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=500&h=500&fit=crop',
    ),
    ServiceType(
      name: 'Épilation',
      icon: FontAwesomeIcons.feather,
      keywords: ['épilation', 'cire'],
      colors: [Color(0xFFFBC2EB), Color(0xFFA6C1EE)],
      imageUrl: 'https://images.unsplash.com/photo-1607779097040-26e80aa4576b?w=500&h=500&fit=crop',
    ),
  ];

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Color _withOpacity(Color color, double opacity) {
    return color.withValues(
      red: color.red.toDouble(),
      green: color.green.toDouble(),
      blue: color.blue.toDouble(),
      alpha: (opacity * 255).toDouble(),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Initialiser les compteurs avec des valeurs aléatoires
    for (var professional in _professionals) {
      _likesCount[professional.id] = 10 + (DateTime.now().millisecondsSinceEpoch % 90);
      _commentsCount[professional.id] = 5 + (DateTime.now().millisecondsSinceEpoch % 45);
    }
  }

  void _toggleLike(String professionalId) {
    setState(() {
      if (_likedPosts[professionalId] ?? false) {
        _likesCount[professionalId] = (_likesCount[professionalId] ?? 0) - 1;
      } else {
        _likesCount[professionalId] = (_likesCount[professionalId] ?? 0) + 1;
      }
      _likedPosts[professionalId] = !(_likedPosts[professionalId] ?? false);
    });
  }

  void _sharePost(Professional professional) {
    final String shareText = "Découvrez ${professional.name}, ${professional.title.toLowerCase()} sur Shayniss!\n\n${professional.description}\n\nPrenez rendez-vous sur l'application Shayniss 💅✨";
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      builder: (BuildContext context) => Container(
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
              child: Text(
                'Partager via',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    icon: FontAwesomeIcons.whatsapp,
                    label: 'WhatsApp',
                    color: const Color(0xFF25D366),
                    onTap: () async {
                      final whatsappUrl = "whatsapp://send?text=${Uri.encodeComponent(shareText)}";
                      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                        await launchUrl(Uri.parse(whatsappUrl));
                      } else {
                        await Share.share(shareText);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 16.w),
                  _buildShareOption(
                    icon: FontAwesomeIcons.facebook,
                    label: 'Facebook',
                    color: const Color(0xFF1877F2),
                    onTap: () async {
                      final facebookUrl = Uri.parse(
                        'https://www.facebook.com/sharer/sharer.php?u=https://shayniss.com&quote=${Uri.encodeComponent(shareText)}'
                      );
                      if (await canLaunchUrl(facebookUrl)) {
                        await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
                      } else {
                        await Share.share(shareText);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 16.w),
                  _buildShareOption(
                    icon: FontAwesomeIcons.twitter,
                    label: 'X (Twitter)',
                    color: Colors.black,
                    onTap: () async {
                      final twitterUrl = Uri.parse(
                        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(shareText)}'
                      );
                      if (await canLaunchUrl(twitterUrl)) {
                        await launchUrl(twitterUrl, mode: LaunchMode.externalApplication);
                      } else {
                        await Share.share(shareText);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 16.w),
                  _buildShareOption(
                    icon: FontAwesomeIcons.instagram,
                    label: 'Instagram',
                    color: const Color(0xFFE4405F),
                    onTap: () async {
                      await Share.share(shareText);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 16.w),
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
                            content: const Text('Le texte a été copié dans le presse-papier'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(width: 16.w),
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
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
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
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 72.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: _withOpacity(color, 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(height: 8.h),
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

  Widget _buildServiceBubble(ServiceType service) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceProvidersScreen(service: service),
          ),
        );
      },
      child: Container(
        width: 140.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: NetworkImage(service.imageUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(red: 0, green: 0, blue: 0, alpha: 25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              service.name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(
                  service.icon,
                  size: 14.sp,
                  color: service.colors[0],
                ),
                SizedBox(width: 4.w),
                Text(
                  '${serviceTypes.length} prestataires',
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
    );
  }

  Widget _buildServicesSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: 200.h,
        margin: EdgeInsets.symmetric(vertical: 16.h),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          scrollDirection: Axis.horizontal,
          itemCount: serviceTypes.length,
          itemBuilder: (context, index) => _buildServiceBubble(serviceTypes[index]),
        ),
      ),
    );
  }

  Widget _buildShareButton(Professional professional) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: IconButton(
        onPressed: () {
          _sharePost(professional);
        },
        icon: Icon(
          FontAwesomeIcons.shareNodes,
          color: AppTheme.primaryColor,
          size: 24.w,
        ),
        padding: EdgeInsets.all(8.w),
        constraints: BoxConstraints(
          minWidth: 40.w,
          minHeight: 40.w,
        ),
        splashRadius: 24.w,
        splashColor: _withOpacity(AppTheme.primaryColor, 0.2),
      ),
    );
  }

  Widget _buildReviewSection(Professional professional) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) => Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: NetworkImage(professional.profileImage),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              professional.name,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  professional.rating.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' (${professional.reviews.length} avis)',
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
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: professional.reviews.length,
                      padding: EdgeInsets.only(top: 16.h),
                      itemBuilder: (context, index) {
                        final review = professional.reviews[index];
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
                                      review['userName'] as String,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      review['date'] as String,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                if (review['comment'] != null) ...[
                                  Text(
                                    review['comment'] as String,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 8.h),
                                ],
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      index < (review['rating'] as double)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 16.sp),
          SizedBox(width: 4.w),
          Text(
            professional.rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ' (${professional.reviews.length})',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    if (!mounted) return;
    setState(() {
      _isLoadingMore = true;
    });
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        _isLoadingMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _loadMoreData() async {
    if (!mounted) return;
    setState(() {
      _isLoadingMore = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        _isLoadingMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _handleError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shayniss',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            _buildServicesSection(),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final professional = _professionals[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: _withOpacity(Colors.black, 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
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
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(professional.profileImage),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    professional.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                _buildReviewSection(professional),
                              ],
                            ),
                            subtitle: Text(
                              professional.title,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          if (professional.description.isNotEmpty) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                professional.description,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[800],
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],
                          if (professional.portfolioImages.isNotEmpty)
                            Container(
                              height: 200.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                itemCount: professional.portfolioImages.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 150.w,
                                    margin: EdgeInsets.only(right: 8.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      image: DecorationImage(
                                        image: NetworkImage(professional.portfolioImages[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _likedPosts[professional.id] ?? false
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _likedPosts[professional.id] ?? false
                                        ? Colors.red
                                        : Colors.grey[600],
                                  ),
                                  onPressed: () => _toggleLike(professional.id),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${_likesCount[professional.id] ?? 0}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.sp,
                                  ),
                                ),
                                const Spacer(),
                                _buildShareButton(professional),
                                SizedBox(width: 16.w),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AppointmentFormScreen(
                                          professional: professional,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryColor,
                                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Prendre RDV',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: _professionals.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
