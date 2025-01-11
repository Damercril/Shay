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
import '../../chat/screens/chat_list_screen.dart';
import '../../chat/services/chat_service.dart';
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
  int _unreadMessagesCount = 0;
  late ChatService _chatService;
  List<Map<String, String>> stories = [];

  static final List<ServiceType> services = [
    ServiceType(
      name: 'Coiffure',
      icon: FontAwesomeIcons.scissors,
      colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
      image: 'https://images.pexels.com/photos/3993444/pexels-photo-3993444.jpeg',
      services: [
        'Coupe femme',
        'Coupe homme',
        'Brushing',
        'Coloration',
        'Mèches',
        'Balayage',
        'Lissage',
        'Permanente',
        'Coiffure de mariage',
        'Extensions',
        'Soins capillaires',
        'Tresses',
      ],
    ),
    ServiceType(
      name: 'Massage',
      icon: FontAwesomeIcons.handHoldingHeart,
      colors: [Color(0xFF88D3CE), Color(0xFF6E45E2)],
      image: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?ixlib=rb-4.0.3',
      services: [
        'Massage relaxant',
        'Massage sportif',
        'Massage californien',
        'Massage thaïlandais',
        'Massage aux pierres chaudes',
        'Massage prénatal',
        'Réflexologie',
        'Massage shiatsu',
        'Massage balinais',
        'Massage ayurvédique',
        'Drainage lymphatique',
        'Massage du dos',
      ],
    ),
    ServiceType(
      name: 'Esthétique',
      icon: FontAwesomeIcons.spa,
      colors: [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
      image: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixlib=rb-4.0.3',
      services: [
        'Soin du visage',
        'Épilation',
        'Manucure',
        'Pédicure',
        'Maquillage',
        'Extension de cils',
        'Microblading',
        'Gommage corporel',
        'Soin anti-âge',
        'Pose d\'ongles',
        'Bronzage',
        'Lifting des cils',
      ],
    ),
    ServiceType(
      name: 'Yoga',
      icon: FontAwesomeIcons.om,
      colors: [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
      image: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-4.0.3',
      services: [
        'Yoga débutant',
        'Yoga avancé',
        'Méditation guidée',
        'Yoga prénatal',
        'Yoga thérapeutique',
        'Yoga aérien',
        'Yoga Vinyasa',
        'Yoga Ashtanga',
        'Yoga Kundalini',
        'Yoga Yin',
        'Yoga pour enfants',
        'Retraites yoga',
      ],
    ),
    ServiceType(
      name: 'Sport',
      icon: FontAwesomeIcons.dumbbell,
      colors: [Color(0xFF5EE7DF), Color(0xFFB490CA)],
      image: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?ixlib=rb-4.0.3',
      services: [
        'Coach personnel',
        'Fitness',
        'Crossfit',
        'Musculation',
        'Cardio training',
        'Stretching',
        'Zumba',
        'Boxe',
        'Pilates',
        'TRX',
        'HIIT',
        'Circuit training',
      ],
    ),
    ServiceType(
      name: 'Nutrition',
      icon: FontAwesomeIcons.carrot,
      colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
      image: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?ixlib=rb-4.0.3',
      services: [
        'Bilan nutritionnel',
        'Plan alimentaire',
        'Coaching minceur',
        'Nutrition sportive',
        'Rééquilibrage alimentaire',
        'Suivi personnalisé',
        'Consultation diététique',
        'Analyse composition corporelle',
        'Nutrition végétarienne',
        'Nutrition végane',
        'Nutrition sans gluten',
        'Nutrition anti-inflammatoire',
      ],
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
    _initChatService();
    _scrollController.addListener(_onScroll);

    // Stories data
    stories = [
      {
        'image': 'https://images.pexels.com/photos/3993444/pexels-photo-3993444.jpeg',
        'title': 'Coiffure',
        'distance': '2.5 km',
      },
      {
        'image': 'https://images.pexels.com/photos/3757942/pexels-photo-3757942.jpeg',
        'title': 'Massage',
        'distance': '3.8 km',
      },
      {
        'image': 'https://images.pexels.com/photos/3985329/pexels-photo-3985329.jpeg',
        'title': 'Esthétique',
        'distance': '1.2 km',
      },
      {
        'image': 'https://images.pexels.com/photos/3822864/pexels-photo-3822864.jpeg',
        'title': 'Yoga',
        'distance': '4.1 km',
      },
      {
        'image': 'https://images.pexels.com/photos/1954524/pexels-photo-1954524.jpeg',
        'title': 'Sport',
        'distance': '0.8 km',
      },
    ];

    // Initialiser les compteurs avec des valeurs aléatoires
    for (var professional in _professionals) {
      _likesCount[professional.id] = 10 + (DateTime.now().millisecondsSinceEpoch % 90);
      _commentsCount[professional.id] = 5 + (DateTime.now().millisecondsSinceEpoch % 45);
    }
  }

  Future<void> _initChatService() async {
    _chatService = await ChatService.init();
    await _updateUnreadCount();
  }

  Future<void> _updateUnreadCount() async {
    if (!mounted) return;
    final count = await _chatService.getUnreadMessagesCount();
    setState(() {
      _unreadMessagesCount = count;
    });
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

  Widget _buildServiceBubble(ServiceType serviceType) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceProvidersScreen(service: serviceType),
          ),
        );
      },
      child: Container(
        width: 160.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: NetworkImage(serviceType.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    serviceType.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${serviceType.services.length} services',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
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
                                    (index) {
                                      final ratings = review['ratings'] as Map<String, double>;
                                      final averageRating = ratings.values.reduce((a, b) => a + b) / ratings.length;
                                      return Icon(
                                        index < averageRating
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                        size: 16.sp,
                                      );
                                    },
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

  Widget _buildServicesSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: 200.h,
        margin: EdgeInsets.symmetric(vertical: 16.h),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          itemBuilder: (context, index) => _buildServiceBubble(services[index]),
        ),
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
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.message_outlined),
                onPressed: _chatService == null
                    ? null
                    : () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatListScreen(),
                          ),
                        );
                        _updateUnreadCount();
                      },
              ),
              if (_unreadMessagesCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 2.r),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18.w,
                      minHeight: 18.w,
                    ),
                    child: Text(
                      _unreadMessagesCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        _likedPosts[professional.id] ?? false
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: _likedPosts[professional.id] ?? false
                                            ? Colors.red
                                            : Colors.grey[600],
                                        size: 24.w,
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
                                  ],
                                ),
                                Row(
                                  children: [
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
