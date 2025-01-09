import 'dart:math' show cos, sqrt, asin, pi;

class Professional {
  final String id;
  final String name;
  final String? imageUrl;
  final List<String> services;
  final String description;
  final double rating;
  final int reviewCount;
  final String location;
  final double latitude;
  final double longitude;

  Professional({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.services,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.latitude,
    required this.longitude,
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
}

// Liste de démonstration de prestataires
final List<Professional> demoProfessionals = [
  Professional(
    id: '1',
    name: 'Emma Dupont',
    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
    services: ['Coiffure'],
    description: 'Spécialiste en colorations et coupes modernes avec 8 ans d\'expérience',
    rating: 4.8,
    reviewCount: 127,
    location: 'Paris 11e',
    latitude: parisLat,
    longitude: parisLng,
  ),
  Professional(
    id: '2',
    name: 'Sophie Martin',
    imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
    services: ['Coiffure', 'Maquillage'],
    description: 'Coiffeuse et maquilleuse professionnelle pour mariages et événements',
    rating: 4.9,
    reviewCount: 89,
    location: 'Paris 16e',
    latitude: parisLat,
    longitude: parisLng,
  ),
  Professional(
    id: '3',
    name: 'Laura Chen',
    imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&h=200&fit=crop',
    services: ['Manucure', 'Soin'],
    description: 'Expert en soins des ongles et soins du visage',
    rating: 4.7,
    reviewCount: 156,
    location: 'Paris 8e',
    latitude: parisLat,
    longitude: parisLng,
  ),
  Professional(
    id: '4',
    name: 'Marie Dubois',
    imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=200&h=200&fit=crop',
    services: ['Massage', 'Soin'],
    description: 'Masseuse certifiée, spécialisée en massages relaxants et thérapeutiques',
    rating: 4.9,
    reviewCount: 203,
    location: 'Paris 15e',
    latitude: parisLat,
    longitude: parisLng,
  ),
  Professional(
    id: '5',
    name: 'Alice Rousseau',
    imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
    services: ['Maquillage', 'Épilation'],
    description: 'Maquilleuse professionnelle pour tous types d\'événements',
    rating: 4.6,
    reviewCount: 94,
    location: 'Paris 9e',
    latitude: parisLat,
    longitude: parisLng,
  ),
];

// Coordonnées de Paris pour la démonstration
const parisLat = 48.8566;
const parisLng = 2.3522;
