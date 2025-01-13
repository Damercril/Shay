class RegisterClientRequest {
  final String name;
  final String phone;
  final String? email;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? birthDate;  // Nouvelle propriété
  final String? gender;     // Nouvelle propriété
  final bool allowPhotos; // Autoriser l'utilisation des photos pour les réseaux sociaux
  final bool allowNotifications; // Autoriser les notifications push
  final String? referralCode; // Code de parrainage

  RegisterClientRequest({
    required this.name,
    required this.phone,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.birthDate,    // Ajouté au constructeur
    this.gender,       // Ajouté au constructeur
    required this.allowPhotos,
    required this.allowNotifications,
    this.referralCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'birthDate': birthDate,  // Ajouté au JSON
      'gender': gender,        // Ajouté au JSON
      'allowPhotos': allowPhotos,
      'allowNotifications': allowNotifications,
      'referralCode': referralCode,
    };
  }
}
