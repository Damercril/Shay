class Client {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime lastAppointment;
  final int totalAppointments;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.lastAppointment,
    required this.totalAppointments,
  });

  // Convert from JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      lastAppointment: DateTime.parse(json['lastAppointment'] as String),
      totalAppointments: json['totalAppointments'] as int,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'lastAppointment': lastAppointment.toIso8601String(),
      'totalAppointments': totalAppointments,
    };
  }
}
