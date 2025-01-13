class RegisterProfessionalRequest {
  final String name;
  final String phone;
  final String? email;
  final String profession;
  final String bio;
  final String? address;
  final double? latitude;
  final double? longitude;
  final bool mobileService;
  final bool noFixedLocation;
  final List<String> languages;
  final List<String> paymentMethods;
  final List<String> specialties;
  final Map<String, Map<String, String>> businessHours;
  final bool requiresDeposit;
  final bool requiresPhotoPayment;
  final bool requiresAppointmentConfirmation;
  final List<String> galleryPhotos;
  final List<String> services;
  final Map<String, String> socialMedia;

  RegisterProfessionalRequest({
    required this.name,
    required this.phone,
    this.email,
    required this.profession,
    required this.bio,
    this.address,
    this.latitude,
    this.longitude,
    required this.mobileService,
    required this.noFixedLocation,
    required this.languages,
    required this.paymentMethods,
    required this.specialties,
    required this.businessHours,
    required this.requiresDeposit,
    required this.requiresPhotoPayment,
    required this.requiresAppointmentConfirmation,
    required this.galleryPhotos,
    required this.services,
    required this.socialMedia,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'profession': profession,
      'bio': bio,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'mobileService': mobileService,
      'noFixedLocation': noFixedLocation,
      'languages': languages,
      'paymentMethods': paymentMethods,
      'specialties': specialties,
      'businessHours': businessHours,
      'requiresDeposit': requiresDeposit,
      'requiresPhotoPayment': requiresPhotoPayment,
      'requiresAppointmentConfirmation': requiresAppointmentConfirmation,
      'galleryPhotos': galleryPhotos,
      'services': services,
      'socialMedia': socialMedia,
    };
  }
}
