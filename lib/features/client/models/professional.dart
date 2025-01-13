class Professional {
  final String id;
  final String name;
  final String title;
  final String description;
  final String profileImage;
  final List<String> portfolioImages;
  final double rating;
  final int reviewCount;
  final List<String> services;
  final String location;
  final bool isAvailable;

  Professional({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.profileImage,
    required this.portfolioImages,
    required this.rating,
    required this.reviewCount,
    required this.services,
    required this.location,
    required this.isAvailable,
  });

  static List<Professional> getDummyProfessionals() {
    return [
      Professional(
        id: '1',
        name: 'Sarah Martin',
        title: 'Coiffeuse styliste',
        description:
            'Spécialisée dans la coloration et le balayage. Plus de 10 ans d\'expérience dans les plus grands salons parisiens.',
        profileImage:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
        portfolioImages: [
          'https://images.unsplash.com/photo-1560869713-da86a9ec0744?w=500',
          'https://images.unsplash.com/photo-1562322140-8baeececf3df?w=500',
          'https://images.unsplash.com/photo-1522336572468-97b06e8ef143?w=500',
        ],
        rating: 4.8,
        reviewCount: 127,
        services: [
          'Coupe femme',
          'Coloration',
          'Balayage',
          'Brushing',
          'Coiffure de mariage',
        ],
        location: 'Paris 8ème',
        isAvailable: true,
      ),
      Professional(
        id: '2',
        name: 'Marie Dubois',
        title: 'Masseuse thérapeute',
        description:
            'Certifiée en massage suédois, deep tissue et massage aux pierres chaudes. Une approche holistique du bien-être.',
        profileImage:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
        portfolioImages: [
          'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=500',
          'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?w=500',
          'https://images.unsplash.com/photo-1515377905703-c4788e51af15?w=500',
        ],
        rating: 4.9,
        reviewCount: 89,
        services: [
          'Massage suédois',
          'Deep tissue',
          'Massage aux pierres chaudes',
          'Réflexologie',
        ],
        location: 'Paris 16ème',
        isAvailable: true,
      ),
      Professional(
        id: '3',
        name: 'Julie Bernard',
        title: 'Esthéticienne',
        description:
            'Experte en soins du visage et manucure. Utilisation exclusive de produits bio et naturels.',
        profileImage:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
        portfolioImages: [
          'https://images.unsplash.com/photo-1519014816548-bf5fe059798b?w=500',
          'https://images.unsplash.com/photo-1522337094846-8a818d7aad23?w=500',
          'https://images.unsplash.com/photo-1522337360788-8b8baeececf3?w=500',
        ],
        rating: 4.7,
        reviewCount: 156,
        services: [
          'Soin du visage',
          'Manucure',
          'Pédicure',
          'Épilation',
          'Maquillage',
        ],
        location: 'Paris 4ème',
        isAvailable: true,
      ),
    ];
  }
}
