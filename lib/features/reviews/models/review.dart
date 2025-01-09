class Review {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String professionalId;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String>? images;
  final int likes;
  final bool verified;

  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.professionalId,
    required this.rating,
    required this.comment,
    required this.date,
    this.images,
    this.likes = 0,
    this.verified = false,
  });

  // Exemple de données pour le développement
  static List<Review> getDummyReviews() {
    return [
      Review(
        id: '1',
        userId: 'user1',
        userName: 'Sophie Martin',
        userImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
        professionalId: 'pro1',
        rating: 5.0,
        comment: 'Service exceptionnel ! Je recommande vivement.',
        date: DateTime.now().subtract(Duration(days: 2)),
        verified: true,
      ),
      Review(
        id: '2',
        userId: 'user2',
        userName: 'Marie Dubois',
        userImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
        professionalId: 'pro1',
        rating: 4.5,
        comment: 'Très satisfaite du résultat. Professionnelle à l\'écoute.',
        date: DateTime.now().subtract(Duration(days: 5)),
        images: [
          'https://images.unsplash.com/photo-1562322140-8baeececf3df',
          'https://images.unsplash.com/photo-1596178060671-7a80dc8059ea',
        ],
        verified: true,
      ),
      Review(
        id: '3',
        userId: 'user3',
        userName: 'Julie Petit',
        userImage: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
        professionalId: 'pro1',
        rating: 5.0,
        comment: 'Une expérience incroyable ! Le résultat est parfait.',
        date: DateTime.now().subtract(Duration(days: 10)),
        images: [
          'https://images.unsplash.com/photo-1562322140-8baeececf3df',
        ],
      ),
    ];
  }
}
