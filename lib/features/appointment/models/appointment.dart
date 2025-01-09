import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

enum PaymentMethod {
  cash,
  card,
  paypal,
  bankTransfer,
  mobileMoney,
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Espèces';
      case PaymentMethod.card:
        return 'Carte bancaire';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.bankTransfer:
        return 'Virement bancaire';
      case PaymentMethod.mobileMoney:
        return 'Mobile Money';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.paypal:
        return Icons.payment;
      case PaymentMethod.bankTransfer:
        return Icons.account_balance;
      case PaymentMethod.mobileMoney:
        return Icons.phone_android;
    }
  }
}

class Appointment {
  final String firstName;
  final String lastName;
  final DateTime dateTime;
  final String service;
  final String? allergies;
  final String? inspirationPhotoUrl;
  final bool isAtHome;
  final LatLng? location;
  final String? personalNote;
  final PaymentMethod paymentMethod;

  const Appointment({
    required this.firstName,
    required this.lastName,
    required this.dateTime,
    required this.service,
    this.allergies,
    this.inspirationPhotoUrl,
    required this.isAtHome,
    this.location,
    this.personalNote,
    required this.paymentMethod,
  });
}
