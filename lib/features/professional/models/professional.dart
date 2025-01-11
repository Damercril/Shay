import 'dart:math';

class Professional {
  final String id;
  final String name;
  final String title;
  final String description;
  final String profileImage;
  final List<String> portfolioImages;
  final List<String> services;
  final Map<String, double> servicesPrices;
  final String address;
  final double latitude;
  final double longitude;
  final Map<String, String> socialMedia;
  final int clientsCount;
  final List<String> specialties;
  final String experience;
  final String education;
  final List<String> languages;
  final List<String> paymentMethods;
  final String availability;
  final List<Map<String, dynamic>> reviews;
  final double rating;
  final bool isOnline;

  int get reviewCount => reviews.length;

  const Professional({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.profileImage,
    required this.portfolioImages,
    required this.services,
    required this.servicesPrices,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.socialMedia,
    required this.clientsCount,
    required this.specialties,
    required this.experience,
    required this.education,
    required this.languages,
    required this.paymentMethods,
    required this.availability,
    required this.reviews,
    required this.rating,
    this.isOnline = false,
  });

  // Calcule la distance entre le professionnel et l'utilisateur
  double getDistanceFrom(double userLat, double userLng) {
    const double earthRadius = 6371; // Rayon de la Terre en kilomètres
    final double latDiff = _toRadians(userLat - latitude);
    final double lngDiff = _toRadians(userLng - longitude);

    final double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(_toRadians(latitude)) *
            cos(_toRadians(userLat)) *
            sin(lngDiff / 2) *
            sin(lngDiff / 2);
    final double c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  static Professional getDummyProfessional() {
    return Professional(
      id: '1',
      name: 'Sarah Martin',
      title: 'Coiffeuse & Maquilleuse professionnelle',
      description: 'Passionnée par la beauté et le bien-être depuis plus de 10 ans. Je me spécialise dans les coiffures de mariage et le maquillage professionnel.',
      profileImage: 'https://i.pravatar.cc/300?img=5',
      portfolioImages: [
        'https://images.pexels.com/photos/3993444/pexels-photo-3993444.jpeg',  
        'https://images.pexels.com/photos/2681751/pexels-photo-2681751.jpeg',  
        'https://images.pexels.com/photos/936554/pexels-photo-936554.jpeg',    
        'https://images.pexels.com/photos/3993321/pexels-photo-3993321.jpeg',  
        'https://images.pexels.com/photos/2896428/pexels-photo-2896428.jpeg',  
        'https://images.pexels.com/photos/2100341/pexels-photo-2100341.jpeg',  
        'https://images.pexels.com/photos/2735727/pexels-photo-2735727.jpeg',  
        'https://images.pexels.com/photos/2923157/pexels-photo-2923157.jpeg'   
      ],
      services: [
        'Coiffure mariage',
        'Maquillage',
        'Coupe femme',
        'Coloration',
        'Brushing',
        'Chignon'
      ],
      servicesPrices: {
        'Coiffure mariage': 150.0,
        'Maquillage': 80.0,
        'Coupe femme': 45.0,
        'Coloration': 120.0,
        'Brushing': 35.0,
        'Chignon': 65.0
      },
      address: 'Bastille, Paris 11e',
      latitude: 48.8531,
      longitude: 2.3698,
      socialMedia: {
        'instagram': '@sarah.beauty',
        'tiktok': '@sarahbeauty',
        'facebook': 'SarahBeautyParis'
      },
      clientsCount: 1500,
      specialties: [
        'Coiffure de mariée',
        'Maquillage naturel',
        'Colorations'
      ],
      experience: '10 ans d\'expérience',
      education: 'Diplômée de l\'École de Coiffure de Paris\nCertification en Maquillage Professionnel',
      languages: ['Français', 'Anglais'],
      paymentMethods: ['Carte bancaire', 'Espèces', 'PayPal'],
      availability: 'Lun-Sam: 9h-19h',
      reviews: [],
      rating: 0.0,
      isOnline: Random().nextBool(),
    );
  }

  static List<Professional> getDummyProfessionals() {
    return [
      Professional(
        id: '1',
        name: 'Aminata Diallo',
        title: 'Coiffeuse spécialisée en tresses africaines',
        description: 'Experte en coiffure africaine avec plus de 15 ans d\'expérience. Spécialisée dans les tresses, nattes, locks et tissages.',
        profileImage: 'https://i.pravatar.cc/300?img=28',
        portfolioImages: [
          'https://images.pexels.com/photos/3065209/pexels-photo-3065209.jpeg',
          'https://images.pexels.com/photos/3065170/pexels-photo-3065170.jpeg',
          'https://images.pexels.com/photos/936554/pexels-photo-936554.jpeg',
          'https://images.pexels.com/photos/2896428/pexels-photo-2896428.jpeg',
          'https://images.pexels.com/photos/2100341/pexels-photo-2100341.jpeg',
          'https://images.pexels.com/photos/2735727/pexels-photo-2735727.jpeg'
        ],
        services: [
          'Tresses',
          'Nattes',
          'Tissage',
          'Locks',
          'Vanilles',
          'Soins capillaires'
        ],
        servicesPrices: {
          'Tresses': 80.0,
          'Nattes': 70.0,
          'Tissage': 150.0,
          'Locks': 100.0,
          'Vanilles': 90.0,
          'Soins capillaires': 45.0
        },
        address: 'Château Rouge, Paris 18e',
        latitude: 48.8853,
        longitude: 2.3493,
        socialMedia: {
          'instagram': '@aminata.hair',
          'facebook': 'Aminata Hair Paris',
          'tiktok': '@aminata.hair'
        },
        clientsCount: 850,
        specialties: [
          'Tresses africaines',
          'Nattes collées',
          'Tissage naturel',
          'Soins des locks'
        ],
        experience: '15 ans d\'expérience en coiffure africaine',
        education: 'Diplômée de l\'École de Coiffure de Dakar\nFormation continue en techniques modernes',
        languages: ['Français', 'Wolof', 'Anglais'],
        paymentMethods: ['Carte bancaire', 'Espèces', 'PayPal'],
        availability: 'Mar-Dim: 10h-20h',
        reviews: [
          {
            'userName': 'Sophie M.',
            'date': '2024-12-28',
            'ratings': {
              'service': 5.0,
              'punctuality': 4.5,
              'price': 4.0,
              'cleanliness': 5.0
            },
            'comment': 'Aminata est une vraie professionnelle ! Mes tresses sont parfaites et elle a été très attentive à mes souhaits. Je recommande vivement !',
            'photos': [
              'https://images.pexels.com/photos/3065209/pexels-photo-3065209.jpeg'
            ]
          },
          {
            'userName': 'Marie L.',
            'date': '2024-12-15',
            'ratings': {
              'service': 5.0,
              'punctuality': 5.0,
              'price': 4.5,
              'cleanliness': 5.0
            },
            'comment': 'Super expérience ! Aminata est très douce et professionnelle. Le résultat est magnifique et tient très bien.',
            'photos': [
              'https://images.pexels.com/photos/3065170/pexels-photo-3065170.jpeg'
            ]
          }
        ],
        rating: 4.7,
        isOnline: Random().nextBool(),
      ),
      Professional(
        id: '2',
        name: 'Yasmine Benali',
        title: 'Maquilleuse Professionnelle & Beauty Artist',
        description: 'Passionnée par l\'art du maquillage et le soin de la peau. Spécialisée dans le maquillage de mariée oriental et les soins traditionnels. Je crée des looks personnalisés qui mettent en valeur votre beauté naturelle tout en respectant vos traditions.',
        profileImage: 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg',
        portfolioImages: [
          'https://images.pexels.com/photos/2442906/pexels-photo-2442906.jpeg',  
          'https://images.pexels.com/photos/2113855/pexels-photo-2113855.jpeg',  
          'https://images.pexels.com/photos/2738920/pexels-photo-2738920.jpeg',  
          'https://images.pexels.com/photos/2746197/pexels-photo-2746197.jpeg',  
          'https://images.pexels.com/photos/3785147/pexels-photo-3785147.jpeg',  
          'https://images.pexels.com/photos/3785170/pexels-photo-3785170.jpeg',  
          'https://images.pexels.com/photos/4620843/pexels-photo-4620843.jpeg',  
          'https://images.pexels.com/photos/4620769/pexels-photo-4620769.jpeg'   
        ],
        services: [
          'Maquillage mariée',
          'Maquillage soirée',
          'Cours d\'auto-maquillage',
          'Soins du visage',
          'Épilation au fil',
          'Henné'
        ],
        servicesPrices: {
          'Maquillage mariée': 200.0,
          'Maquillage soirée': 80.0,
          'Cours d\'auto-maquillage': 120.0,
          'Soins du visage': 60.0,
          'Épilation au fil': 30.0,
          'Henné': 50.0
        },
        address: 'Belleville, Paris 20e',
        latitude: 48.8717,
        longitude: 2.3798,
        socialMedia: {
          'instagram': '@yasmine.beauty',
          'tiktok': '@yasminebeautyart',
          'youtube': '@YasmineBeauty'
        },
        clientsCount: 800,
        specialties: [
          'Maquillage oriental',
          'Soins traditionnels',
          'Art du henné'
        ],
        experience: '8 ans d\'expérience',
        education: 'Formation en Maquillage Professionnel\nSpécialisation en Soins Orientaux',
        languages: ['Français', 'Arabe', 'Anglais'],
        paymentMethods: ['Carte bancaire', 'Espèces'],
        availability: 'Lun-Sam: 10h-20h',
        reviews: [],
        rating: 0.0,
        isOnline: Random().nextBool(),
      ),
      Professional(
        id: '3',
        name: 'Chen Wei',
        title: 'Masseuse & Thérapeute Holistique',
        description: 'Experte en médecine traditionnelle chinoise et techniques de massage. Je propose une approche holistique du bien-être, combinant massages thérapeutiques, acupression et conseils en nutrition selon les principes de la MTC.',
        profileImage: 'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg',
        portfolioImages: [
          'https://images.pexels.com/photos/3997993/pexels-photo-3997993.jpeg',  
          'https://images.pexels.com/photos/3997385/pexels-photo-3997385.jpeg',  
          'https://images.pexels.com/photos/3188/love-romantic-bath-candlelight.jpg',  
          'https://images.pexels.com/photos/3865557/pexels-photo-3865557.jpeg',  
          'https://images.pexels.com/photos/3865676/pexels-photo-3865676.jpeg',  
          'https://images.pexels.com/photos/3865720/pexels-photo-3865720.jpeg',  
          'https://images.pexels.com/photos/3865742/pexels-photo-3865742.jpeg',  
          'https://images.pexels.com/photos/3865785/pexels-photo-3865785.jpeg'   
        ],
        services: [
          'Massage traditionnel chinois',
          'Acupression',
          'Massage aux pierres chaudes',
          'Réflexologie',
          'Consultation MTC',
          'Massage relaxant'
        ],
        servicesPrices: {
          'Massage traditionnel chinois': 90.0,
          'Acupression': 70.0,
          'Massage aux pierres chaudes': 100.0,
          'Réflexologie': 60.0,
          'Consultation MTC': 50.0,
          'Massage relaxant': 80.0
        },
        address: 'Arts et Métiers, Paris 3e',
        latitude: 48.8645,
        longitude: 2.3635,
        socialMedia: {
          'instagram': '@chen.wellness',
          'wechat': 'ChenWellness',
          'facebook': 'ChenHolisticTherapy'
        },
        clientsCount: 600,
        specialties: [
          'Médecine traditionnelle chinoise',
          'Massages thérapeutiques',
          'Acupression'
        ],
        experience: '15 ans d\'expérience',
        education: 'Diplômée de l\'Université de MTC de Shanghai\nCertification en Massages Thérapeutiques',
        languages: ['Français', 'Chinois', 'Anglais'],
        paymentMethods: ['Carte bancaire', 'Espèces', 'WeChat Pay'],
        availability: 'Mer-Dim: 11h-21h',
        reviews: [],
        rating: 0.0,
        isOnline: Random().nextBool(),
      ),
      Professional(
        id: '4',
        name: 'Sofia Rodriguez',
        title: 'Nail Artist & Manucure',
        description: 'Créatrice de nail art et spécialiste en soins des ongles. Je transforme vos ongles en véritables œuvres d\'art tout en garantissant leur santé. Expertise en techniques innovantes et designs personnalisés.',
        profileImage: 'https://images.pexels.com/photos/1587009/pexels-photo-1587009.jpeg',
        portfolioImages: [
          'https://images.pexels.com/photos/939836/pexels-photo-939836.jpeg',  
          'https://images.pexels.com/photos/3997386/pexels-photo-3997386.jpeg',  
          'https://images.pexels.com/photos/3997373/pexels-photo-3997373.jpeg',  
          'https://images.pexels.com/photos/4046316/pexels-photo-4046316.jpeg',  
          'https://images.pexels.com/photos/4046317/pexels-photo-4046317.jpeg',  
          'https://images.pexels.com/photos/4046320/pexels-photo-4046320.jpeg',  
          'https://images.pexels.com/photos/4210784/pexels-photo-4210784.jpeg',  
          'https://images.pexels.com/photos/4210799/pexels-photo-4210799.jpeg'   
        ],
        services: [
          'Pose complète gel',
          'Remplissage gel',
          'Nail art',
          'Manucure simple',
          'Pédicure',
          'Dépose'
        ],
        servicesPrices: {
          'Pose complète gel': 70.0,
          'Remplissage gel': 45.0,
          'Nail art': 20.0,
          'Manucure simple': 30.0,
          'Pédicure': 40.0,
          'Dépose': 20.0
        },
        address: 'Oberkampf, Paris 11e',
        latitude: 48.8649,
        longitude: 2.3785,
        socialMedia: {
          'instagram': '@sofia.nails',
          'tiktok': '@sofianailart',
          'pinterest': '@sofianaildesign'
        },
        clientsCount: 950,
        specialties: [
          'Nail art créatif',
          'Pose gel',
          'Soins des ongles'
        ],
        experience: '6 ans d\'expérience',
        education: 'Formation en Prothésie Ongulaire\nCertification en Nail Art Avancé',
        languages: ['Français', 'Espagnol'],
        paymentMethods: ['Carte bancaire', 'Espèces'],
        availability: 'Mar-Sam: 10h-19h',
        reviews: [],
        rating: 0.0,
        isOnline: Random().nextBool(),
      ),
    ];
  }
}
