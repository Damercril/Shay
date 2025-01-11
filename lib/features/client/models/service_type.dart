import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceType {
  final String name;
  final IconData icon;
  final List<Color> colors;
  final String image;
  final List<String> services;

  const ServiceType({
    required this.name,
    required this.icon,
    required this.colors,
    required this.image,
    required this.services,
  });

  static const List<ServiceType> all = [
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
      name: 'Sport',
      icon: FontAwesomeIcons.dumbbell,
      colors: [Color(0xFF5EE7DF), Color(0xFFB490CA)],
      image: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?ixlib=rb-4.0.3',
      services: [
        'Coach personnel',
        'Yoga',
        'Pilates',
        'Fitness',
        'Crossfit',
        'Musculation',
        'Cardio training',
        'Stretching',
        'Zumba',
        'Boxe',
        'Aquagym',
        'Méditation',
      ],
    ),
    ServiceType(
      name: 'Bien-être',
      icon: FontAwesomeIcons.heart,
      colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
      image: 'https://images.unsplash.com/photo-1552693673-1bf958298935?ixlib=rb-4.0.3',
      services: [
        'Sophrologie',
        'Naturopathie',
        'Acupuncture',
        'Hypnose',
        'Reiki',
        'Aromathérapie',
        'Coaching bien-être',
        'Luminothérapie',
        'Thérapie holistique',
        'Méditation guidée',
        'Yoga thérapeutique',
        'Consultation nutrition',
      ],
    ),
    ServiceType(
      name: 'Coaching',
      icon: FontAwesomeIcons.userTie,
      colors: [Color(0xFFA8EDEA), Color(0xFFFED6E3)],
      image: 'https://images.unsplash.com/photo-1519452635265-7b1fbfd1e4e0?ixlib=rb-4.0.3',
      services: [
        'Développement personnel',
        'Coaching professionnel',
        'Coaching relationnel',
        'Gestion du stress',
        'Prise de parole',
        'Image de soi',
        'Coaching carrière',
        'Leadership',
        'Communication',
        'Gestion du temps',
        'Motivation',
        'Confiance en soi',
      ],
    ),
  ];
}
