import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../models/professional.dart';
import '../screens/professionals_list_screen.dart';
import 'professional_profile_screen.dart';

class ServiceType {
  final String name;
  final IconData icon;
  final List<String> keywords;
  final List<Color> colors;
  final List<String> demoImages;

  const ServiceType({
    required this.name,
    required this.icon,
    required this.keywords,
    required this.colors,
    required this.demoImages,
  });
}

class ProHomeTab extends StatefulWidget {
  const ProHomeTab({super.key});

  @override
  State<ProHomeTab> createState() => _ProHomeTabState();
}

class _ProHomeTabState extends State<ProHomeTab> {
  static const List<ServiceType> serviceTypes = [
    ServiceType(
      name: 'Coiffure',
      icon: FontAwesomeIcons.scissors,
      keywords: ['coiffure', 'cheveux', 'coupe'],
      colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
      demoImages: ['assets/images/services/coiffure.jpg'],
    ),
    ServiceType(
      name: 'Manucure',
      icon: FontAwesomeIcons.handSparkles,
      keywords: ['manucure', 'ongles', 'nail'],
      colors: [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
      demoImages: ['assets/images/services/manucure.jpg'],
    ),
    ServiceType(
      name: 'Soin',
      icon: FontAwesomeIcons.spa,
      keywords: ['soin', 'visage', 'facial'],
      colors: [Color(0xFF96E6A1), Color(0xFFD4FC79)],
      demoImages: ['assets/images/services/soin.jpg'],
    ),
    ServiceType(
      name: 'Massage',
      icon: FontAwesomeIcons.handHoldingHeart,
      keywords: ['massage', 'détente'],
      colors: [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
      demoImages: ['assets/images/services/massage.jpg'],
    ),
    ServiceType(
      name: 'Maquillage',
      icon: FontAwesomeIcons.wandMagicSparkles,
      keywords: ['maquillage', 'makeup'],
      colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
      demoImages: ['assets/images/services/maquillage.jpg'],
    ),
    ServiceType(
      name: 'Épilation',
      icon: FontAwesomeIcons.feather,
      keywords: ['épilation', 'cire'],
      colors: [Color(0xFFFBC2EB), Color(0xFFA6C1EE)],
      demoImages: ['assets/images/services/epilation.jpg'],
    ),
  ];

  final List<Map<String, String>> posts = [
    {
      'name': 'Sarah B.',
      'description': 'Nouvelle coupe et balayage pour cette cliente 💇‍♀️✨ #coiffure #balayage',
      'likes': '28',
      'comments': '5',
      'image': 'https://images.unsplash.com/photo-1620331311520-246422fd82f9?w=500&h=400&fit=crop',
    },
    {
      'name': 'Marie K.',
      'description': 'Manucure et nail art pour un résultat élégant 💅 #nailart #manucure',
      'likes': '34',
      'comments': '7',
      'image': 'https://images.unsplash.com/photo-1519014816548-bf5fe059798b?w=500&h=400&fit=crop',
    },
    {
      'name': 'Laura M.',
      'description': 'Soin du visage relaxant et hydratant 🧖‍♀️ #skincare #beauté',
      'likes': '45',
      'comments': '9',
      'image': 'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?w=500&h=400&fit=crop',
    },
    {
      'name': 'Julie D.',
      'description': 'Maquillage naturel pour sublimer la beauté naturelle ✨ #makeup #natural',
      'likes': '52',
      'comments': '12',
      'image': 'https://images.unsplash.com/photo-1596704017234-0e0d0f5f0cde?w=500&h=400&fit=crop',
    },
  ];

  // Position simulée de l'utilisateur (Paris centre)
  final userLatitude = 48.8566;
  final userLongitude = 2.3522;

  final List<Professional> professionals = [
    // Coiffure
    Professional(
      id: '1',
      name: 'Sarah B.',
      imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=200&h=200&fit=crop',
      services: ['Coiffure'],
      description: 'Spécialiste en colorations et coupes modernes avec 8 ans d\'expérience',
      rating: 4.8,
      reviewCount: 127,
      location: 'Paris 11e',
      latitude: 48.8589,
      longitude: 2.3781,
    ),
    Professional(
      id: '2',
      name: 'Emma D.',
      imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
      services: ['Coiffure', 'Maquillage'],
      description: 'Coiffeuse et maquilleuse spécialisée dans les mariages et événements',
      rating: 4.9,
      reviewCount: 203,
      location: 'Paris 16e',
      latitude: 48.8566,
      longitude: 2.2769,
    ),
    Professional(
      id: '3',
      name: 'Thomas R.',
      imageUrl: 'https://images.unsplash.com/photo-1492288991661-058aa541ff43?w=200&h=200&fit=crop',
      services: ['Coiffure'],
      description: 'Expert en coupes homme et barbe, techniques modernes et traditionnelles',
      rating: 4.7,
      reviewCount: 156,
      location: 'Paris 2e',
      latitude: 48.8687,
      longitude: 2.3412,
    ),

    // Manucure
    Professional(
      id: '4',
      name: 'Marie K.',
      imageUrl: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=200&h=200&fit=crop',
      services: ['Manucure', 'Soin'],
      description: 'Expert en soins des ongles et manucure avec une touche artistique',
      rating: 4.7,
      reviewCount: 89,
      location: 'Paris 9e',
      latitude: 48.8760,
      longitude: 2.3340,
    ),
    Professional(
      id: '5',
      name: 'Nina P.',
      imageUrl: 'https://images.unsplash.com/photo-1595959183082-7b570b7e08e2?w=200&h=200&fit=crop',
      services: ['Manucure'],
      description: 'Spécialiste du nail art et des designs personnalisés',
      rating: 4.9,
      reviewCount: 178,
      location: 'Paris 8e',
      latitude: 48.8726,
      longitude: 2.3126,
    ),
    Professional(
      id: '6',
      name: 'Léa M.',
      imageUrl: 'https://images.unsplash.com/photo-1517365830460-955ce3ccd263?w=200&h=200&fit=crop',
      services: ['Manucure', 'Pédicure'],
      description: 'Experte en soins des mains et des pieds, spécialisation vernis semi-permanent',
      rating: 4.8,
      reviewCount: 145,
      location: 'Paris 4e',
      latitude: 48.8550,
      longitude: 2.3574,
    ),

    // Soin
    Professional(
      id: '7',
      name: 'Laura M.',
      imageUrl: 'https://images.unsplash.com/photo-1512290923902-8a9f81dc236c?w=200&h=200&fit=crop',
      services: ['Soin', 'Massage'],
      description: 'Esthéticienne spécialisée en soins du visage et massages relaxants',
      rating: 4.9,
      reviewCount: 156,
      location: 'Paris 16e',
      latitude: 48.8637,
      longitude: 2.2769,
    ),
    Professional(
      id: '8',
      name: 'Sophie V.',
      imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=200&h=200&fit=crop',
      services: ['Soin'],
      description: 'Spécialiste en soins anti-âge et traitements personnalisés',
      rating: 4.8,
      reviewCount: 167,
      location: 'Paris 7e',
      latitude: 48.8588,
      longitude: 2.3159,
    ),
    Professional(
      id: '9',
      name: 'Claire D.',
      imageUrl: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=200&h=200&fit=crop',
      services: ['Soin', 'Épilation'],
      description: 'Experte en soins du corps et épilation définitive',
      rating: 4.7,
      reviewCount: 134,
      location: 'Paris 15e',
      latitude: 48.8417,
      longitude: 2.2911,
    ),

    // Massage
    Professional(
      id: '10',
      name: 'David L.',
      imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&h=200&fit=crop',
      services: ['Massage'],
      description: 'Massothérapeute spécialisé en massages thérapeutiques et sportifs',
      rating: 4.9,
      reviewCount: 189,
      location: 'Paris 17e',
      latitude: 48.8818,
      longitude: 2.3215,
    ),
    Professional(
      id: '11',
      name: 'Anne S.',
      imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
      services: ['Massage', 'Soin'],
      description: 'Praticienne en massages ayurvédiques et soins holistiques',
      rating: 4.8,
      reviewCount: 143,
      location: 'Paris 6e',
      latitude: 48.8495,
      longitude: 2.3364,
    ),

    // Maquillage
    Professional(
      id: '12',
      name: 'Julie D.',
      imageUrl: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=200&h=200&fit=crop',
      services: ['Maquillage', 'Soin'],
      description: 'Maquilleuse professionnelle pour tous types d\'événements',
      rating: 4.6,
      reviewCount: 94,
      location: 'Paris 8e',
      latitude: 48.8726,
      longitude: 2.3126,
    ),
    Professional(
      id: '13',
      name: 'Camille R.',
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      services: ['Maquillage'],
      description: 'Spécialiste du maquillage naturel et des techniques japonaises',
      rating: 4.9,
      reviewCount: 167,
      location: 'Paris 3e',
      latitude: 48.8637,
      longitude: 2.3615,
    ),
    Professional(
      id: '14',
      name: 'Marine L.',
      imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&h=200&fit=crop',
      services: ['Maquillage', 'Coiffure'],
      description: 'Artiste make-up et coiffure pour photos et défilés',
      rating: 4.8,
      reviewCount: 182,
      location: 'Paris 1er',
      latitude: 48.8637,
      longitude: 2.3371,
    ),

    // Épilation
    Professional(
      id: '15',
      name: 'Sophie L.',
      imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200&h=200&fit=crop',
      services: ['Épilation', 'Soin'],
      description: 'Experte en épilation et soins de la peau',
      rating: 4.8,
      reviewCount: 112,
      location: 'Paris 15e',
      latitude: 48.8417,
      longitude: 2.2911,
    ),
    Professional(
      id: '16',
      name: 'Nadia H.',
      imageUrl: 'https://images.unsplash.com/photo-1557053910-d9eadeed1c58?w=200&h=200&fit=crop',
      services: ['Épilation'],
      description: 'Spécialiste de l\'épilation au fil et à la cire orientale',
      rating: 4.9,
      reviewCount: 223,
      location: 'Paris 10e',
      latitude: 48.8760,
      longitude: 2.3595,
    ),

    // Nouveaux professionnels ajoutés
    Professional(
      id: '17',
      name: 'Lucas M.',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
      services: ['Coiffure', 'Barber'],
      description: 'Spécialiste de la coupe homme et barbe, style vintage et moderne',
      rating: 4.9,
      reviewCount: 245,
      location: 'Paris 18e',
      latitude: 48.8925,
      longitude: 2.3444,
    ),
    Professional(
      id: '18',
      name: 'Amélie P.',
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      services: ['Maquillage', 'Coiffure'],
      description: 'Spécialiste maquillage et coiffure pour mariages et événements',
      rating: 4.7,
      reviewCount: 156,
      location: 'Paris 5e',
      latitude: 48.8448,
      longitude: 2.3451,
    ),
    Professional(
      id: '19',
      name: 'Yasmine K.',
      imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
      services: ['Épilation', 'Soin'],
      description: 'Experte en épilation orientale et soins traditionnels',
      rating: 4.8,
      reviewCount: 178,
      location: 'Paris 19e',
      latitude: 48.8827,
      longitude: 2.3821,
    ),
    Professional(
      id: '20',
      name: 'Antoine B.',
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop',
      services: ['Massage', 'Soin'],
      description: 'Masseur-kinésithérapeute spécialisé en massage sportif et thérapeutique',
      rating: 4.9,
      reviewCount: 201,
      location: 'Paris 14e',
      latitude: 48.8330,
      longitude: 2.3264,
    ),
    Professional(
      id: '21',
      name: 'Chloé D.',
      imageUrl: 'https://images.unsplash.com/photo-1534751516642-a1af1ef26a56?w=200&h=200&fit=crop',
      services: ['Manucure', 'Pédicure'],
      description: 'Spécialiste en nail art japonais et soins des pieds',
      rating: 4.8,
      reviewCount: 167,
      location: 'Paris 12e',
      latitude: 48.8399,
      longitude: 2.3876,
    ),
    Professional(
      id: '22',
      name: 'Gabriel H.',
      imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&h=200&fit=crop',
      services: ['Coiffure'],
      description: 'Expert en coloration et techniques de balayage',
      rating: 4.7,
      reviewCount: 134,
      location: 'Paris 13e',
      latitude: 48.8322,
      longitude: 2.3561,
    ),
  ];

  Widget _buildProfessionalCard(Professional professional) {
    final distance = professional.getDistanceFrom(userLatitude, userLongitude);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfessionalProfileScreen(professional: professional),
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
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_on, 
                                color: AppTheme.primaryColor, 
                                size: 14.sp
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implémenter le rafraîchissement
        },
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 85.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    _buildServiceBubble(
                      imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=200&h=200&fit=crop',
                      label: 'Coiffure',
                      colors: [const Color(0xFFFF9A9E), const Color(0xFFFAD0C4)],
                    ),
                    _buildServiceBubble(
                      imageUrl: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=200&h=200&fit=crop',
                      label: 'Manucure',
                      colors: [const Color(0xFFA18CD1), const Color(0xFFFBC2EB)],
                    ),
                    _buildServiceBubble(
                      imageUrl: 'https://images.unsplash.com/photo-1512290923902-8a9f81dc236c?w=200&h=200&fit=crop',
                      label: 'Soin',
                      colors: [const Color(0xFF96E6A1), const Color(0xFFD4FC79)],
                    ),
                    _buildServiceBubble(
                      imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=200&h=200&fit=crop',
                      label: 'Massage',
                      colors: [const Color(0xFF84FAB0), const Color(0xFF8FD3F4)],
                    ),
                    _buildServiceBubble(
                      imageUrl: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=200&h=200&fit=crop',
                      label: 'Maquillage',
                      colors: [const Color(0xFFFF9A9E), const Color(0xFFFECFEF)],
                    ),
                    _buildServiceBubble(
                      imageUrl: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=200&h=200&fit=crop',
                      label: 'Épilation',
                      colors: [const Color(0xFFFBC2EB), const Color(0xFFA6C1EE)],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final post = posts[index];
                  return _buildFeedItem(
                    username: post['name']!,
                    description: post['description']!,
                    likes: post['likes']!,
                    comments: post['comments']!,
                  );
                },
                childCount: posts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 1,
      toolbarHeight: 48.h,
      title: Row(
        children: [
          Text(
            'Shayniss',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const Spacer(),
          Text(
            'Publications récentes',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          IconButton(
            icon: Icon(Icons.sort, size: 20.sp),
            onPressed: () {
              // TODO: Implémenter le tri des publications
            },
            color: AppTheme.primaryColor,
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: InkWell(
            onTap: () {
              // TODO: Implémenter l'ajout de publication
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    color: AppTheme.primaryColor,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Ajouter une publication',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceBubble({
    required String imageUrl,
    required String label,
    required List<Color> colors,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colors[0].withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfessionalsListScreen(
                        serviceType: label,
                        professionals: professionals,
                      ),
                    ),
                  );
                },
                customBorder: const CircleBorder(),
                child: ClipOval(
                  child: Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        width: 45.w,
                        height: 45.w,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: colors[0].withOpacity(0.1),
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: colors[0],
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: colors[0].withOpacity(0.1),
                            child: Icon(
                              Icons.image_not_supported,
                              color: colors[0],
                              size: 20.sp,
                            ),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colors[0].withOpacity(0.3),
                              colors[1].withOpacity(0.3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: 45.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedItem({
    required String username,
    required String description,
    required String likes,
    required String comments,
  }) {
    final post = posts.firstWhere(
      (post) => post['name'] == username,
      orElse: () => posts[0],
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: AppTheme.shadowSmall,
                  ),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                    child: Text(
                      username[0].toUpperCase(),
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor,
                        ),
                      ),
                      Text(
                        'Il y a 2 heures',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppTheme.subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              post['image']!,
              width: double.infinity,
              height: 250.h,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: double.infinity,
                  height: 250.h,
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 250.h,
                  color: Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.grey[400],
                        size: 48.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Image non disponible',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInteractionButton(
                      icon: Icons.favorite_border,
                      label: likes,
                      color: AppTheme.textColor,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement booking logic
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        size: 18.sp,
                        color: AppTheme.textColor,
                      ),
                      label: Text(
                        'Prendre RDV',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppTheme.textColor,
                        backgroundColor: const Color(0xFFE6E1F9), // Violet clair
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ).copyWith(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xFFD4CCF7); // Violet un peu plus foncé pour l'état pressé
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(text: description),
                    ],
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.textColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: 24.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
