import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../models/professional.dart';
import '../screens/professionals_list_screen.dart';
import 'professional_profile_screen.dart';
import '../../reviews/models/review.dart';
import '../../reviews/screens/reviews_screen.dart';

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

class _ProHomeTabState extends State<ProHomeTab> with TickerProviderStateMixin {
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
      title: 'Coiffeuse professionnelle',
      description: 'Spécialiste en colorations et coupes modernes avec 8 ans d\'expérience',
      profileImage: 'https://images.unsplash.com/photo-1522337360788-8baeececf3df?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1562322140-8baeececf3df',
        'https://images.unsplash.com/photo-1596178060671-7a80dc8059ea',
      ],
      services: ['Coiffure'],
      servicesPrices: {
        'Coiffure femme': 45.0,
        'Coloration': 65.0,
      },
      address: 'Paris 11e',
      latitude: 48.8589,
      longitude: 2.3781,
      socialMedia: {
        'instagram': '@sarah.beauty',
        'facebook': 'SarahBeauty',
      },
      clientsCount: 500,
      specialties: ['Colorations', 'Coupes modernes'],
      experience: '8 ans d\'expérience',
      education: 'Diplôme de coiffure - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Samedi, 9h - 19h',
    ),
    Professional(
      id: '2',
      name: 'Emma D.',
      title: 'Coiffeuse et maquilleuse professionnelle',
      description: 'Coiffeuse et maquilleuse spécialisée dans les mariages et événements',
      profileImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1559599101-f09722fb4948',
        'https://images.unsplash.com/photo-1565538420870-da08ff96a207',
      ],
      services: ['Coiffure', 'Maquillage'],
      servicesPrices: {
        'Coiffure mariage': 150.0,
        'Maquillage mariée': 100.0,
      },
      address: 'Paris 16e',
      latitude: 48.8566,
      longitude: 2.2769,
      socialMedia: {
        'instagram': '@emma.beauty',
        'facebook': 'EmmaBeauty',
      },
      clientsCount: 800,
      specialties: ['Mariages', 'Événements'],
      experience: '10 ans d\'expérience',
      education: 'Diplôme de coiffure et maquillage - École de Paris',
      languages: const ['Français', 'Anglais', 'Espagnol'],
      paymentMethods: const ['Carte bancaire', 'Espèces', 'Virement'],
      availability: 'Lundi - Dimanche, sur rendez-vous',
    ),
    Professional(
      id: '3',
      name: 'Thomas R.',
      title: 'Coiffeur barbier',
      description: 'Expert en coupes homme et barbe, techniques modernes et traditionnelles',
      profileImage: 'https://images.unsplash.com/photo-1492288991661-058aa541ff43?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1579187707643-35646d22b596',
        'https://images.unsplash.com/photo-1565538420870-da08ff96a207',
      ],
      services: ['Coiffure'],
      servicesPrices: {
        'Coupe homme': 35.0,
        'Barbe': 25.0,
      },
      address: 'Paris 2e',
      latitude: 48.8687,
      longitude: 2.3412,
      socialMedia: {
        'instagram': '@thomas.barber',
        'facebook': 'ThomasBarber',
      },
      clientsCount: 600,
      specialties: ['Coupes homme', 'Barbe'],
      experience: '5 ans d\'expérience',
      education: 'Diplôme de barbier - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Mardi - Samedi, 10h - 20h',
    ),

    // Manucure
    Professional(
      id: '4',
      name: 'Marie K.',
      title: 'Manucure professionnelle',
      description: 'Expert en soins des ongles et manucure avec une touche artistique',
      profileImage: 'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1604654894610-df63bc536371',
        'https://images.unsplash.com/photo-1565538420870-da08ff96a207',
      ],
      services: ['Manucure', 'Soin'],
      servicesPrices: {
        'Manucure simple': 35.0,
        'Nail art': 50.0,
      },
      address: 'Paris 9e',
      latitude: 48.8760,
      longitude: 2.3340,
      socialMedia: {
        'instagram': '@marie.nails',
        'facebook': 'MarieNails',
      },
      clientsCount: 300,
      specialties: ['Nail art', 'Soins des ongles'],
      experience: '3 ans d\'expérience',
      education: 'Diplôme de manucure - École de Paris',
      languages: const ['Français'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Vendredi, 9h - 18h',
    ),
    Professional(
      id: '5',
      name: 'Nina P.',
      title: 'Nail artist',
      description: 'Spécialiste du nail art et des designs personnalisés',
      profileImage: 'https://images.unsplash.com/photo-1595959183082-7b570b7e08e2?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1595959183082-7b570b7e08e2',
        'https://images.unsplash.com/photo-1565538420870-da08ff96a207',
      ],
      services: ['Manucure'],
      servicesPrices: {
        'Manucure': 40.0,
        'Nail art personnalisé': 60.0,
      },
      address: 'Paris 8e',
      latitude: 48.8726,
      longitude: 2.3126,
      socialMedia: {
        'instagram': '@nina.nailart',
        'facebook': 'NinaNailArt',
      },
      clientsCount: 400,
      specialties: ['Nail art personnalisé', 'Designs créatifs'],
      experience: '4 ans d\'expérience',
      education: 'Certification nail art - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Samedi, 10h - 19h',
    ),
    Professional(
      id: '6',
      name: 'Léa M.',
      title: 'Manucure et pédicure',
      description: 'Experte en soins des mains et des pieds, spécialisation vernis semi-permanent',
      profileImage: 'https://images.unsplash.com/photo-1517365830460-da08ff96a207?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1519014816548-bf5fe059798c',
        'https://images.unsplash.com/photo-1604654894610-df63bc536371',
      ],
      services: ['Manucure', 'Pédicure'],
      servicesPrices: {
        'Manucure': 35.0,
        'Pédicure': 45.0,
        'Vernis semi-permanent': 50.0,
      },
      address: 'Paris 15e',
      latitude: 48.8417,
      longitude: 2.2911,
      socialMedia: {
        'instagram': '@lea.beauty',
        'facebook': 'LeaBeauty',
      },
      clientsCount: 450,
      specialties: ['Vernis semi-permanent', 'Soins des pieds'],
      experience: '6 ans d\'expérience',
      education: 'Diplôme d\'esthéticienne - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Samedi, 9h - 18h',
    ),
    Professional(
      id: '7',
      name: 'Sophie L.',
      title: 'Esthéticienne',
      description: 'Spécialiste en soins du visage et épilation',
      profileImage: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
        'https://images.unsplash.com/photo-1598952946667-8af9b5b17a62',
      ],
      services: ['Soin visage', 'Épilation'],
      servicesPrices: {
        'Soin visage': 60.0,
        'Épilation complète': 80.0,
      },
      address: 'Paris 17e',
      latitude: 48.8859,
      longitude: 2.3222,
      socialMedia: {
        'instagram': '@sophie.beauty',
        'facebook': 'SophieBeauty',
      },
      clientsCount: 350,
      specialties: ['Soins du visage', 'Épilation'],
      experience: '4 ans d\'expérience',
      education: 'Diplôme d\'esthéticienne - École de Paris',
      languages: const ['Français'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Mardi - Samedi, 10h - 19h',
    ),
    Professional(
      id: '8',
      name: 'Julie R.',
      title: 'Maquilleuse professionnelle',
      description: 'Maquilleuse spécialisée en mariages et événements',
      profileImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1588177806780-51d6f102b1b1',
        'https://images.unsplash.com/photo-1587463272361-565200f82b33',
      ],
      services: ['Maquillage'],
      servicesPrices: {
        'Maquillage jour': 50.0,
        'Maquillage mariée': 120.0,
      },
      address: 'Paris 4e',
      latitude: 48.8566,
      longitude: 2.3522,
      socialMedia: {
        'instagram': '@julie.makeup',
        'facebook': 'JulieMakeup',
      },
      clientsCount: 250,
      specialties: ['Maquillage mariée', 'Maquillage événementiel'],
      experience: '3 ans d\'expérience',
      education: 'Formation maquillage professionnel - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Dimanche, sur rendez-vous',
    ),
    Professional(
      id: '9',
      name: 'Marc D.',
      title: 'Barbier',
      description: 'Expert en taille de barbe et soins pour homme',
      profileImage: 'https://images.unsplash.com/photo-1500648767791-dfd03ed5d881?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1503951914875-452162b0f3f1',
        'https://images.unsplash.com/photo-1521119989659-a83eee488004',
      ],
      services: ['Barbe', 'Coiffure homme'],
      servicesPrices: {
        'Taille de barbe': 30.0,
        'Coupe homme': 35.0,
      },
      address: 'Paris 3e',
      latitude: 48.8625,
      longitude: 2.3627,
      socialMedia: {
        'instagram': '@marc.barber',
        'facebook': 'MarcBarber',
      },
      clientsCount: 300,
      specialties: ['Barbe', 'Coiffure homme'],
      experience: '5 ans d\'expérience',
      education: 'Formation barbier - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Mardi - Samedi, 10h - 20h',
    ),
    Professional(
      id: '10',
      name: 'Anne S.',
      title: 'Coiffeuse styliste',
      description: 'Spécialiste en coiffure de mariée et événementielle',
      profileImage: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1595476108010-b4d1f102b1b1',
        'https://images.unsplash.com/photo-1580618672591-eb180b1a973f',
      ],
      services: ['Coiffure'],
      servicesPrices: {
        'Coiffure mariée': 150.0,
        'Coiffure événement': 80.0,
      },
      address: 'Paris 6e',
      latitude: 48.8495,
      longitude: 2.3364,
      socialMedia: {
        'instagram': '@anne.hair',
        'facebook': 'AnneHair',
      },
      clientsCount: 400,
      specialties: ['Coiffure mariée', 'Coiffure événementielle'],
      experience: '7 ans d\'expérience',
      education: 'Diplôme de coiffure - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces', 'Virement'],
      availability: 'Lundi - Dimanche, sur rendez-vous',
    ),

    // Soin
    Professional(
      id: '11',
      name: 'Laura M.',
      title: 'Thérapeute bien-être',
      description: 'Spécialiste en soins du corps et massages relaxants',
      profileImage: 'https://images.unsplash.com/photo-1512290923902-8a9f81dc236c?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1540555700478-4be289fbecef',
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
      ],
      services: ['Soin', 'Massage'],
      servicesPrices: {
        'Massage relaxant': 70.0,
        'Soin du corps': 80.0,
      },
      address: 'Paris 16e',
      latitude: 48.8566,
      longitude: 2.2769,
      socialMedia: {
        'instagram': '@laura.wellness',
        'facebook': 'LauraWellness',
      },
      clientsCount: 280,
      specialties: ['Massages relaxants', 'Soins du corps'],
      experience: '5 ans d\'expérience',
      education: 'Diplôme de massothérapeute - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Samedi, 9h - 20h',
    ),
    Professional(
      id: '12',
      name: 'Sophie V.',
      title: 'Esthéticienne spécialisée',
      description: 'Experte en soins du visage et traitements anti-âge',
      profileImage: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
        'https://images.unsplash.com/photo-1598952946667-8af9b5b17a62',
      ],
      services: ['Soin'],
      servicesPrices: {
        'Soin du visage': 75.0,
        'Traitement anti-âge': 120.0,
      },
      address: 'Paris 8e',
      latitude: 48.8661,
      longitude: 2.3159,
      socialMedia: {
        'instagram': '@sophie.beauty',
        'facebook': 'SophieBeauty',
      },
      clientsCount: 320,
      specialties: ['Soins anti-âge', 'Traitements spécifiques'],
      experience: '8 ans d\'expérience',
      education: 'Diplôme d\'esthéticienne - École de Paris',
      languages: const ['Français', 'Anglais', 'Espagnol'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Mardi - Samedi, 10h - 19h',
    ),
    Professional(
      id: '13',
      name: 'Claire D.',
      title: 'Esthéticienne',
      description: 'Spécialiste en soins et épilation',
      profileImage: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
        'https://images.unsplash.com/photo-1598952946667-8af9b5b17a62',
      ],
      services: ['Soin', 'Épilation'],
      servicesPrices: {
        'Soin du visage': 65.0,
        'Épilation complète': 80.0,
      },
      address: 'Paris 12e',
      latitude: 48.8399,
      longitude: 2.3876,
      socialMedia: {
        'instagram': '@claire.beauty',
        'facebook': 'ClaireBeauty',
      },
      clientsCount: 290,
      specialties: ['Épilation', 'Soins du visage'],
      experience: '4 ans d\'expérience',
      education: 'Diplôme d\'esthéticienne - École de Paris',
      languages: const ['Français'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Vendredi, 9h - 18h',
    ),
    Professional(
      id: '14',
      name: 'David L.',
      title: 'Massothérapeute',
      description: 'Expert en massages thérapeutiques et sportifs',
      profileImage: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1540555700478-4be289fbecef',
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
      ],
      services: ['Massage'],
      servicesPrices: {
        'Massage thérapeutique': 80.0,
        'Massage sportif': 90.0,
      },
      address: 'Paris 7e',
      latitude: 48.8583,
      longitude: 2.3215,
      socialMedia: {
        'instagram': '@david.massage',
        'facebook': 'DavidMassage',
      },
      clientsCount: 350,
      specialties: ['Massage thérapeutique', 'Massage sportif'],
      experience: '7 ans d\'expérience',
      education: 'Diplôme de massothérapeute - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Samedi, 8h - 20h',
    ),
    Professional(
      id: '15',
      name: 'Anne S.',
      title: 'Thérapeute holistique',
      description: 'Spécialiste en massages et soins énergétiques',
      profileImage: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1540555700478-4be289fbecef',
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
      ],
      services: ['Massage', 'Soin'],
      servicesPrices: {
        'Massage énergétique': 85.0,
        'Soin holistique': 95.0,
      },
      address: 'Paris 5e',
      latitude: 48.8448,
      longitude: 2.3451,
      socialMedia: {
        'instagram': '@anne.holistic',
        'facebook': 'AnneHolistic',
      },
      clientsCount: 270,
      specialties: ['Massages énergétiques', 'Soins holistiques'],
      experience: '6 ans d\'expérience',
      education: 'Formation en thérapies holistiques - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Mardi - Samedi, 9h - 19h',
    ),

    // Massage
    Professional(
      id: '16',
      name: 'Julie D.',
      title: 'Maquilleuse professionnelle',
      description: 'Experte en maquillage et soins du visage',
      profileImage: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1588177806780-51d6f5b069f7',
        'https://images.unsplash.com/photo-1587463272361-565200f82b33',
      ],
      services: ['Maquillage', 'Soin'],
      servicesPrices: {
        'Maquillage jour': 55.0,
        'Maquillage soirée': 75.0,
        'Soin du visage': 65.0,
      },
      address: 'Paris 8e',
      latitude: 48.8726,
      longitude: 2.3126,
      socialMedia: {
        'instagram': '@julie.makeup',
        'facebook': 'JulieMakeup',
      },
      clientsCount: 310,
      specialties: ['Maquillage événementiel', 'Soins du visage'],
      experience: '5 ans d\'expérience',
      education: 'Formation maquillage professionnel - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Samedi, 9h - 19h',
    ),
    Professional(
      id: '17',
      name: 'Camille R.',
      title: 'Maquilleuse artistique',
      description: 'Spécialiste en maquillage artistique et effets spéciaux',
      profileImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1588177806780-51d6f5b069f7',
        'https://images.unsplash.com/photo-1587463272361-565200f82b33',
      ],
      services: ['Maquillage'],
      servicesPrices: {
        'Maquillage artistique': 90.0,
        'Effets spéciaux': 120.0,
      },
      address: 'Paris 11e',
      latitude: 48.8589,
      longitude: 2.3615,
      socialMedia: {
        'instagram': '@camille.art',
        'facebook': 'CamilleArtMakeup',
      },
      clientsCount: 240,
      specialties: ['Maquillage artistique', 'Effets spéciaux'],
      experience: '4 ans d\'expérience',
      education: 'Formation maquillage artistique - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Sur rendez-vous',
    ),
    Professional(
      id: '18',
      name: 'Marine L.',
      title: 'Maquilleuse et coiffeuse',
      description: 'Spécialiste en maquillage et coiffure pour événements',
      profileImage: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1588177806780-51d6f5b069f7',
        'https://images.unsplash.com/photo-1562322140-8baeececf3df',
      ],
      services: ['Maquillage', 'Coiffure'],
      servicesPrices: {
        'Maquillage et coiffure mariée': 180.0,
        'Maquillage et coiffure événement': 120.0,
      },
      address: 'Paris 4e',
      latitude: 48.8566,
      longitude: 2.3522,
      socialMedia: {
        'instagram': '@marine.beauty',
        'facebook': 'MarineBeauty',
      },
      clientsCount: 280,
      specialties: ['Mariages', 'Événements'],
      experience: '6 ans d\'expérience',
      education: 'Formation maquillage et coiffure - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces', 'Virement'],
      availability: 'Sur rendez-vous',
    ),

    // Épilation
    Professional(
      id: '19',
      name: 'Nadia B.',
      title: 'Esthéticienne spécialisée',
      description: 'Experte en épilation et soins du corps',
      profileImage: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
        'https://images.unsplash.com/photo-1598952946667-8af9b5b17a62',
      ],
      services: ['Épilation', 'Soin'],
      servicesPrices: {
        'Épilation complète': 85.0,
        'Épilation jambes': 35.0,
        'Soin du corps': 70.0,
      },
      address: 'Paris 15e',
      latitude: 48.8417,
      longitude: 2.2911,
      socialMedia: {
        'instagram': '@nadia.beauty',
        'facebook': 'NadiaBeauty',
      },
      clientsCount: 290,
      specialties: ['Épilation définitive', 'Soins du corps'],
      experience: '7 ans d\'expérience',
      education: 'Diplôme d\'esthéticienne - École de Paris',
      languages: const ['Français', 'Arabe'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Mardi - Samedi, 10h - 19h',
    ),
    Professional(
      id: '20',
      name: 'Léa P.',
      title: 'Esthéticienne',
      description: 'Spécialiste en épilation et soins esthétiques',
      profileImage: 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
        'https://images.unsplash.com/photo-1598952946667-8af9b5b17a62',
      ],
      services: ['Épilation', 'Soin'],
      servicesPrices: {
        'Épilation complète': 80.0,
        'Épilation visage': 20.0,
        'Soin visage': 60.0,
      },
      address: 'Paris 9e',
      latitude: 48.8761,
      longitude: 2.3364,
      socialMedia: {
        'instagram': '@lea.beauty',
        'facebook': 'LeaBeauty',
      },
      clientsCount: 260,
      specialties: ['Épilation', 'Soins du visage'],
      experience: '4 ans d\'expérience',
      education: 'Diplôme d\'esthéticienne - École de Paris',
      languages: const ['Français'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Vendredi, 9h - 18h',
    ),
    Professional(
      id: '21',
      name: 'Sarah M.',
      title: 'Esthéticienne spécialisée',
      description: 'Experte en épilation et soins anti-âge',
      profileImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
        'https://images.unsplash.com/photo-1598952946667-8af9b5b17a62',
      ],
      services: ['Épilation', 'Soin'],
      servicesPrices: {
        'Épilation complète': 90.0,
        'Soin anti-âge': 120.0,
      },
      address: 'Paris 16e',
      latitude: 48.8637,
      longitude: 2.2769,
      socialMedia: {
        'instagram': '@sarah.beauty',
        'facebook': 'SarahBeauty',
      },
      clientsCount: 320,
      specialties: ['Épilation définitive', 'Soins anti-âge'],
      experience: '8 ans d\'expérience',
      education: 'Diplôme d\'esthéticienne - École de Paris',
      languages: const ['Français', 'Anglais', 'Espagnol'],
      paymentMethods: const ['Carte bancaire', 'Espèces', 'Virement'],
      availability: 'Lundi - Samedi, 9h - 20h',
    ),
    Professional(
      id: '22',
      name: 'Lucas M.',
      title: 'Coiffeur et barbier',
      description: 'Expert en coupe homme et taille de barbe',
      profileImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1503951914875-452162b0f3f1',
        'https://images.unsplash.com/photo-1521119989659-a83eee488004',
      ],
      services: ['Coiffure', 'Barber'],
      servicesPrices: {
        'Coupe homme': 35.0,
        'Taille barbe': 25.0,
        'Coupe + barbe': 55.0,
      },
      address: 'Paris 18e',
      latitude: 48.8925,
      longitude: 2.3444,
      socialMedia: {
        'instagram': '@lucas.barber',
        'facebook': 'LucasBarber',
      },
      clientsCount: 380,
      specialties: ['Coupe homme', 'Taille de barbe'],
      experience: '6 ans d\'expérience',
      education: 'Formation barbier - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Mardi - Samedi, 10h - 19h',
    ),
    Professional(
      id: '23',
      name: 'Antoine D.',
      title: 'Coiffeur coloriste',
      description: 'Spécialiste en coloration et techniques innovantes',
      profileImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1562322140-8baeececf3df',
        'https://images.unsplash.com/photo-1605497788044-5a32c7078486',
      ],
      services: ['Coiffure'],
      servicesPrices: {
        'Coloration complète': 95.0,
        'Mèches': 110.0,
        'Coupe + coloration': 140.0,
      },
      address: 'Paris 7e',
      latitude: 48.8588,
      longitude: 2.3159,
      socialMedia: {
        'instagram': '@antoine.color',
        'facebook': 'AntoineColor',
      },
      clientsCount: 340,
      specialties: ['Coloration avancée', 'Techniques innovantes'],
      experience: '9 ans d\'expérience',
      education: 'Formation coloration - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces', 'Virement'],
      availability: 'Lundi - Samedi, 9h - 19h',
    ),
    Professional(
      id: '24',
      name: 'Marie F.',
      title: 'Coiffeuse styliste',
      description: 'Experte en coiffure de mariage et événements',
      profileImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1562322140-8baeececf3df',
        'https://images.unsplash.com/photo-1605497788044-5a32c7078486',
      ],
      services: ['Coiffure'],
      servicesPrices: {
        'Coiffure mariée': 150.0,
        'Coiffure événement': 85.0,
        'Essai coiffure': 60.0,
      },
      address: 'Paris 4e',
      latitude: 48.8566,
      longitude: 2.3522,
      socialMedia: {
        'instagram': '@marie.wedding',
        'facebook': 'MarieWedding',
      },
      clientsCount: 290,
      specialties: ['Coiffure mariage', 'Chignons'],
      experience: '7 ans d\'expérience',
      education: 'Formation coiffure - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces', 'Virement'],
      availability: 'Sur rendez-vous',
    ),
    Professional(
      id: '25',
      name: 'Pierre L.',
      title: 'Coiffeur coloriste',
      description: 'Expert en coloration et techniques innovantes',
      profileImage: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1562322140-8baeececf3df',
        'https://images.unsplash.com/photo-1605497788044-5a32c7078486',
      ],
      services: ['Coiffure'],
      servicesPrices: {
        'Coloration complète': 95.0,
        'Mèches': 110.0,
        'Coupe + coloration': 140.0,
      },
      address: 'Paris 2e',
      latitude: 48.8666,
      longitude: 2.3333,
      socialMedia: {
        'instagram': '@pierre.color',
        'facebook': 'PierreColor',
      },
      clientsCount: 310,
      specialties: ['Coloration avancée', 'Techniques innovantes'],
      experience: '10 ans d\'expérience',
      education: 'Formation coloration - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Mardi - Samedi, 10h - 19h',
    ),
    Professional(
      id: '26',
      name: 'Charlotte B.',
      title: 'Coiffeuse visagiste',
      description: 'Spécialiste en transformation et relooking',
      profileImage: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
      portfolioImages: [
        'https://images.unsplash.com/photo-1562322140-8baeececf3df',
        'https://images.unsplash.com/photo-1605497788044-5a32c7078486',
      ],
      services: ['Coiffure'],
      servicesPrices: {
        'Consultation visagisme': 45.0,
        'Coupe transformation': 85.0,
        'Relooking complet': 160.0,
      },
      address: 'Paris 6e',
      latitude: 48.8495,
      longitude: 2.3364,
      socialMedia: {
        'instagram': '@charlotte.style',
        'facebook': 'CharlotteStyle',
      },
      clientsCount: 270,
      specialties: ['Relooking', 'Visagisme'],
      experience: '6 ans d\'expérience',
      education: 'Formation visagisme - École de Paris',
      languages: const ['Français', 'Anglais'],
      paymentMethods: const ['Carte bancaire', 'Espèces'],
      availability: 'Lundi - Vendredi, 9h - 18h',
    ),
  ];

  final Map<String, bool> _likedPosts = {};
  final Map<String, bool> _savedPosts = {};
  final Map<String, AnimationController> _likeAnimationControllers = {};
  final Map<String, AnimationController> _saveAnimationControllers = {};
  final Map<String, AnimationController> _shareAnimationControllers = {};
  final Map<String, Animation<double>> _likeScaleAnimations = {};
  final Map<String, Animation<double>> _saveScaleAnimations = {};
  final Map<String, Animation<double>> _shareScaleAnimations = {};

  void _showShareOptions(BuildContext context, String text, String userName) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final offset = box?.localToGlobal(Offset.zero) ?? Offset.zero;
    final size = box?.size ?? Size.zero;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: SafeArea(
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
                        color: Color(0xFF25D366),
                        onTap: () async {
                          final whatsappUrl = Uri.parse(
                            'whatsapp://send?text=${Uri.encodeComponent(text)}'
                          );
                          if (await canLaunchUrl(whatsappUrl)) {
                            await launchUrl(whatsappUrl);
                          } else {
                            Share.share(text);
                          }
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 16.w),
                      _buildShareOption(
                        icon: FontAwesomeIcons.facebook,
                        label: 'Facebook',
                        color: Color(0xFF1877F2),
                        onTap: () async {
                          final facebookUrl = Uri.parse(
                            'https://www.facebook.com/sharer/sharer.php?u=https://shayniss.com&quote=${Uri.encodeComponent(text)}'
                          );
                          if (await canLaunchUrl(facebookUrl)) {
                            await launchUrl(facebookUrl);
                          } else {
                            Share.share(text);
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
                            'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}'
                          );
                          if (await canLaunchUrl(twitterUrl)) {
                            await launchUrl(twitterUrl);
                          } else {
                            Share.share(text);
                          }
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 16.w),
                      _buildShareOption(
                        icon: FontAwesomeIcons.instagram,
                        label: 'Instagram',
                        color: Color(0xFFE4405F),
                        onTap: () async {
                          Share.share(text);
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 16.w),
                      _buildShareOption(
                        icon: Icons.copy,
                        label: 'Copier',
                        color: Colors.grey[700]!,
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(text: text));
                          Navigator.pop(context);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Le texte a été copié dans le presse-papier'),
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
                          await Share.share(text);
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
      },
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
                color: color.withOpacity(0.1),
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

  void _showReviews(BuildContext context, String userName) {
    final reviews = Review.getDummyReviews();
    final averageRating = reviews.fold<double>(0, (sum, review) => sum + review.rating) / reviews.length;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
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
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note moyenne',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Text(
                              averageRating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[800],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < averageRating.floor()
                                      ? Icons.star
                                      : index < averageRating
                                          ? Icons.star_half
                                          : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20.sp,
                                );
                              }),
                            ),
                          ],
                        ),
                        Text(
                          '${reviews.length} avis',
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
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: reviews.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16.r,
                                backgroundImage: NetworkImage(review.userImage),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.userName,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          starIndex < review.rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 14.sp,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (review.comment.isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            Text(
                              review.comment,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                          if (review.images != null && review.images!.isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            SizedBox(
                              height: 80.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: review.images!.length,
                                itemBuilder: (context, imageIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        review.images![imageIndex],
                                        width: 80.w,
                                        height: 80.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _likeAnimationControllers.values.forEach((controller) => controller.dispose());
    _saveAnimationControllers.values.forEach((controller) => controller.dispose());
    _shareAnimationControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

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
              if (professional.profileImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    professional.profileImage!,
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
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < 4 ? Icons.star : Icons.star_half,
                              color: Colors.amber,
                              size: 16.sp,
                            );
                          }),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (128)',
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
                  final professional = professionals.firstWhere(
                    (professional) => professional.name == post['name'],
                    orElse: () => professionals[0],
                  );
                  return _buildFeedItem(
                    userName: post['name']!,
                    userImage: professional.profileImage!,
                    description: post['description']!,
                    imageUrl: post['image']!,
                    likes: int.parse(post['likes']!),
                    comments: int.parse(post['comments']!),
                    professional: professional,
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
    required String userName,
    required String userImage,
    required String description,
    required String imageUrl,
    required int likes,
    required int comments,
    required Professional professional,
  }) {
    // Initialiser les animations si elles n'existent pas déjà
    if (!_likeAnimationControllers.containsKey(imageUrl)) {
      _likeAnimationControllers[imageUrl] = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      _saveAnimationControllers[imageUrl] = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      _shareAnimationControllers[imageUrl] = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      _likeScaleAnimations[imageUrl] = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.4)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.4, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50,
        ),
      ]).animate(_likeAnimationControllers[imageUrl]!);

      _saveScaleAnimations[imageUrl] = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.8)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.8, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50,
        ),
      ]).animate(_saveAnimationControllers[imageUrl]!);

      _shareScaleAnimations[imageUrl] = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.8)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.8, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50,
        ),
      ]).animate(_shareAnimationControllers[imageUrl]!);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                GestureDetector(
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
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(userImage),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      InkWell(
                        onTap: () {
                          _showReviews(context, userName);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '4.8',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber[800],
                                ),
                              ),
                              Text(
                                ' (127)',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.more_vert, size: 20.sp),
                  onPressed: () {
                    // TODO: Implémenter le menu d'options
                  },
                ),
              ],
            ),
          ),
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 48.w,  
                          height: 48.w,
                          child: ScaleTransition(
                            scale: _likeScaleAnimations[imageUrl]!,
                            child: IconButton(
                              icon: Icon(
                                _likedPosts[imageUrl] == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 24.sp,
                                color: _likedPosts[imageUrl] == true
                                    ? Colors.red
                                    : AppTheme.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _likedPosts[imageUrl] = !(_likedPosts[imageUrl] ?? false);
                                  if (_likedPosts[imageUrl] == true) {
                                    _likeAnimationControllers[imageUrl]!.forward().then((_) {
                                      _likeAnimationControllers[imageUrl]!.reset();
                                    });
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          (_likedPosts[imageUrl] == true ? likes + 1 : likes).toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppTheme.primaryColor,
                            fontWeight: _likedPosts[imageUrl] == true
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 48.w,
                      height: 48.w,
                      child: ScaleTransition(
                        scale: _saveScaleAnimations[imageUrl]!,
                        child: IconButton(
                          icon: Icon(
                            _savedPosts[imageUrl] == true
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 24.sp,
                            color: _savedPosts[imageUrl] == true
                                ? AppTheme.primaryColor
                                : AppTheme.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _savedPosts[imageUrl] = !(_savedPosts[imageUrl] ?? false);
                              _saveAnimationControllers[imageUrl]!.forward().then((_) {
                                _saveAnimationControllers[imageUrl]!.reset();
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 48.w,
                      height: 48.w,
                      child: ScaleTransition(
                        scale: _shareScaleAnimations[imageUrl]!,
                        child: IconButton(
                          icon: Icon(
                            Icons.share,
                            size: 24.sp,
                            color: AppTheme.primaryColor,
                          ),
                          onPressed: () async {
                            _shareAnimationControllers[imageUrl]!.forward().then((_) {
                              _shareAnimationControllers[imageUrl]!.reset();
                            });
                            
                            final String shareText = 'Découvrez cette publication de $userName sur Shayniss!\n\n"$description"\n\nTéléchargez l\'application Shayniss pour en voir plus!';
                            
                            _showShareOptions(context, shareText, userName);
                          },
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfessionalProfileScreen(
                              professional: professional,
                              initialTabIndex: 1, // Index de l'onglet Rendez-vous
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        size: 18.sp,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Prendre RDV',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        elevation: 0,
                      ).copyWith(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white.withOpacity(0.1);
                            }
                            return null;
                          },
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
  }
}
