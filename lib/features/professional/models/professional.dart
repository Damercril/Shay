import 'dart:math' show cos, sqrt, asin, pi;

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
  });

  double getDistanceFrom(double userLat, double userLng) {
    const p = pi / 180; // Math.PI / 180
    final a = 0.5 -
        cos((userLat - latitude) * p) / 2 +
        cos(latitude * p) *
            cos(userLat * p) *
            (1 - cos((userLng - longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  static Professional getDummyProfessional() {
    return Professional(
      id: '1',
      name: 'Sarah Martin',
      title: 'Coiffeuse & Maquilleuse professionnelle',
      description: 'Passionnée par la beauté et le bien-être depuis plus de 10 ans. Je me spécialise dans les coiffures de mariage et le maquillage professionnel.',
      profileImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      portfolioImages: [
        'https://images.unsplash.com/photo-1562322140-8baeececf3df',
        'https://images.unsplash.com/photo-1596178060671-7a80dc8059ea',
        'https://images.unsplash.com/photo-1559599101-f09722fb4948',
        'https://images.unsplash.com/photo-1565538420870-da08ff96a207',
        'https://images.unsplash.com/photo-1579187707643-35646d22b596',
      ],
      services: [
        'Coiffure mariage',
        'Maquillage événementiel',
        'Coloration',
        'Coupe femme',
        'Brushing',
        'Extensions de cils',
      ],
      servicesPrices: {
        'Coiffure mariage': 150.0,
        'Maquillage événementiel': 80.0,
        'Coloration': 65.0,
        'Coupe femme': 45.0,
        'Brushing': 35.0,
        'Extensions de cils': 90.0,
      },
      address: '15 Rue de la République, 75001 Paris',
      latitude: 48.8566,
      longitude: 2.3522,
      socialMedia: {
        'instagram': '@sarah.beauty.paris',
        'facebook': 'SarahBeautyParis',
        'tiktok': '@sarahbeautypro',
      },
      clientsCount: 1500,
      specialties: [
        'Coiffures de mariée',
        'Maquillage naturel',
        'Colorations végétales',
        'Soins des cheveux',
      ],
      experience: '10 ans d\'expérience',
      education: 'Diplômée de l\'École de Coiffure de Paris\nCertification en Maquillage Professionnel',
      languages: ['Français', 'Anglais', 'Espagnol'],
      paymentMethods: ['Carte bancaire', 'Espèces', 'PayPal'],
      availability: 'Lun-Sam: 9h-19h',
    );
  }
}

// Liste de démonstration de prestataires
final List<Professional> demoProfessionals = [
  Professional(
    id: '1',
    name: 'Emma Dupont',
    title: 'Coiffeuse',
    description: 'Spécialiste en colorations et coupes modernes avec 8 ans d\'expérience',
    profileImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
    portfolioImages: [],
    services: ['Coiffure'],
    servicesPrices: {
      'Coiffure': 50.0,
    },
    address: 'Paris 11e',
    latitude: 48.8566,
    longitude: 2.3522,
    socialMedia: {
      'instagram': '@emma.dupont',
    },
    clientsCount: 500,
    specialties: ['Coiffures modernes'],
    experience: '8 ans d\'expérience',
    education: 'Diplômée de l\'École de Coiffure de Paris',
    languages: ['Français'],
    paymentMethods: ['Carte bancaire', 'Espèces'],
    availability: 'Lun-Sam: 9h-19h',
  ),
  Professional(
    id: '2',
    name: 'Sophie Martin',
    title: 'Coiffeuse & Maquilleuse',
    description: 'Coiffeuse et maquilleuse professionnelle pour mariages et événements',
    profileImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
    portfolioImages: [],
    services: ['Coiffure', 'Maquillage'],
    servicesPrices: {
      'Coiffure': 60.0,
      'Maquillage': 80.0,
    },
    address: 'Paris 16e',
    latitude: 48.8566,
    longitude: 2.3522,
    socialMedia: {
      'instagram': '@sophie.martin',
    },
    clientsCount: 800,
    specialties: ['Coiffures de mariée', 'Maquillage naturel'],
    experience: '10 ans d\'expérience',
    education: 'Diplômée de l\'École de Coiffure de Paris\nCertification en Maquillage Professionnel',
    languages: ['Français', 'Anglais'],
    paymentMethods: ['Carte bancaire', 'Espèces', 'PayPal'],
    availability: 'Lun-Sam: 9h-19h',
  ),
  Professional(
    id: '3',
    name: 'Laura Chen',
    title: 'Manucure & Soin',
    description: 'Expert en soins des ongles et soins du visage',
    profileImage: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&h=200&fit=crop',
    portfolioImages: [],
    services: ['Manucure', 'Soin'],
    servicesPrices: {
      'Manucure': 30.0,
      'Soin': 40.0,
    },
    address: 'Paris 8e',
    latitude: 48.8566,
    longitude: 2.3522,
    socialMedia: {
      'instagram': '@laura.chen',
    },
    clientsCount: 600,
    specialties: ['Soins des ongles', 'Soins du visage'],
    experience: '6 ans d\'expérience',
    education: 'Diplômée de l\'École de Beauté de Paris',
    languages: ['Français', 'Chinois'],
    paymentMethods: ['Carte bancaire', 'Espèces'],
    availability: 'Lun-Sam: 9h-19h',
  ),
  Professional(
    id: '4',
    name: 'Marie Dubois',
    title: 'Masseuse',
    description: 'Masseuse certifiée, spécialisée en massages relaxants et thérapeutiques',
    profileImage: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=200&h=200&fit=crop',
    portfolioImages: [],
    services: ['Massage'],
    servicesPrices: {
      'Massage': 50.0,
    },
    address: 'Paris 15e',
    latitude: 48.8566,
    longitude: 2.3522,
    socialMedia: {
      'instagram': '@marie.dubois',
    },
    clientsCount: 700,
    specialties: ['Massages relaxants', 'Massages thérapeutiques'],
    experience: '8 ans d\'expérience',
    education: 'Diplômée de l\'École de Massage de Paris',
    languages: ['Français'],
    paymentMethods: ['Carte bancaire', 'Espèces'],
    availability: 'Lun-Sam: 9h-19h',
  ),
  Professional(
    id: '5',
    name: 'Alice Rousseau',
    title: 'Maquilleuse',
    description: 'Maquilleuse professionnelle pour tous types d\'événements',
    profileImage: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
    portfolioImages: [],
    services: ['Maquillage'],
    servicesPrices: {
      'Maquillage': 70.0,
    },
    address: 'Paris 9e',
    latitude: 48.8566,
    longitude: 2.3522,
    socialMedia: {
      'instagram': '@alice.rousseau',
    },
    clientsCount: 900,
    specialties: ['Maquillage naturel', 'Maquillage événementiel'],
    experience: '10 ans d\'expérience',
    education: 'Diplômée de l\'École de Maquillage de Paris',
    languages: ['Français', 'Anglais'],
    paymentMethods: ['Carte bancaire', 'Espèces', 'PayPal'],
    availability: 'Lun-Sam: 9h-19h',
  ),
];

// Coordonnées de Paris pour la démonstration
const parisLat = 48.8566;
const parisLng = 2.3522;
