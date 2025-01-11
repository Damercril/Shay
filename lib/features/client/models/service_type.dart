import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceType {
  final String name;
  final IconData icon;
  final List<String> keywords;
  final List<Color> colors;
  final String imageUrl;

  const ServiceType({
    required this.name,
    required this.icon,
    required this.keywords,
    required this.colors,
    required this.imageUrl,
  });
}
