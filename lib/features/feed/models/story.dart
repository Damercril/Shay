import 'package:shayniss/features/professional/models/professional.dart';

class Story {
  final String id;
  final Professional professional;
  final String imageUrl;
  final DateTime createdAt;
  final bool isViewed;

  Story({
    required this.id,
    required this.professional,
    required this.imageUrl,
    required this.createdAt,
    this.isViewed = false,
  });

  static List<Story> getDummyStories() {
    final professionals = Professional.getDummyProfessionals();
    return [
      Story(
        id: '1',
        professional: professionals[0], // Aminata
        imageUrl: 'https://images.unsplash.com/photo-1595476108010-b4d1f102b1b1?q=80&w=1000&auto=format&fit=crop',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Story(
        id: '2',
        professional: professionals[1], // Yasmine
        imageUrl: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?q=80&w=1000&auto=format&fit=crop',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      Story(
        id: '3',
        professional: professionals[2], // Chen Wei
        imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?q=80&w=1000&auto=format&fit=crop',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
      Story(
        id: '4',
        professional: professionals[3], // Sofia
        imageUrl: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?q=80&w=1000&auto=format&fit=crop',
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      ),
    ];
  }
}
