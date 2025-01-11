import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class ClientAppointmentsTab extends StatefulWidget {
  const ClientAppointmentsTab({super.key});

  @override
  State<ClientAppointmentsTab> createState() => _ClientAppointmentsTabState();
}

class _ClientAppointmentsTabState extends State<ClientAppointmentsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showNotificationBadge = true;

  final List<Map<String, dynamic>> _upcomingAppointments = [
    {
      'professionalName': 'Sarah B.',
      'service': 'Coiffure',
      'date': '15 Jan 2024',
      'time': '14:30',
      'status': 'En attente',
      'image': 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=200&h=200&fit=crop',
      'price': 45.0,
      'duration': '1h30',
      'address': '123 rue de Paris, 75001 Paris',
      'isConfirmed': false,
      'reminder': true,
    },
    {
      'professionalName': 'Emma D.',
      'service': 'Maquillage',
      'date': '18 Jan 2024',
      'time': '10:00',
      'status': 'Confirmé',
      'image': 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=200&h=200&fit=crop',
      'price': 60.0,
      'duration': '1h',
      'address': '45 avenue des Champs-Élysées, 75008 Paris',
      'isConfirmed': true,
      'reminder': true,
    },
  ];

  final List<Map<String, dynamic>> _pastAppointments = [
    {
      'professionalName': 'Marie L.',
      'service': 'Manucure',
      'date': '5 Jan 2024',
      'time': '11:00',
      'status': 'Terminé',
      'image': 'https://images.unsplash.com/photo-1534885320675-b08aa131cc5e?w=200&h=200&fit=crop',
      'price': 35.0,
      'duration': '45min',
      'address': '78 rue du Commerce, 75015 Paris',
      'isConfirmed': true,
      'rating': 5,
    },
    {
      'professionalName': 'Julie R.',
      'service': 'Massage',
      'date': '28 Déc 2023',
      'time': '15:00',
      'status': 'Terminé',
      'image': 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=200&h=200&fit=crop',
      'price': 80.0,
      'duration': '1h',
      'address': '15 rue de Vaugirard, 75006 Paris',
      'isConfirmed': true,
      'rating': 4,
    },
  ];

  final TextEditingController _commentController = TextEditingController();
  List<String>? _selectedPhotos;

  @override
  void dispose() {
    _commentController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _showAppointmentDetails(Map<String, dynamic> appointment, bool isPast) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(appointment['image']),
                  radius: 30.r,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['professionalName'],
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        appointment['service'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isPast)
                  IconButton(
                    icon: Icon(
                      appointment['reminder'] ? Icons.notifications_active : Icons.notifications_off,
                      color: appointment['reminder'] ? AppTheme.primaryColor : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        appointment['reminder'] = !appointment['reminder'];
                      });
                    },
                  ),
              ],
            ),
            SizedBox(height: 24.h),
            _buildDetailRow(Icons.calendar_today, 'Date', '${appointment['date']} à ${appointment['time']}'),
            SizedBox(height: 16.h),
            _buildDetailRow(Icons.timer, 'Durée', appointment['duration']),
            SizedBox(height: 16.h),
            _buildDetailRow(Icons.location_on, 'Lieu', appointment['address']),
            SizedBox(height: 16.h),
            _buildDetailRow(Icons.euro, 'Prix', '${appointment['price'].toStringAsFixed(2)} €'),
            if (isPast && appointment['rating'] != null) ...[
              SizedBox(height: 16.h),
              _buildDetailRow(
                Icons.star,
                'Note',
                '${appointment['rating']}/5',
              ),
            ],
            SizedBox(height: 24.h),
            if (!isPast) ...[
              if (!appointment['isConfirmed'])
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        appointment['status'] = 'Confirmé';
                        appointment['isConfirmed'] = true;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Confirmer le rendez-vous',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Annuler le rendez-vous'),
                        content: Text('Êtes-vous sûr de vouloir annuler ce rendez-vous ?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Non'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                // Trouver le rendez-vous à annuler
                                final appointmentToCancel = _upcomingAppointments.firstWhere(
                                  (item) => 
                                    item['professionalName'] == appointment['professionalName'] &&
                                    item['date'] == appointment['date'] &&
                                    item['time'] == appointment['time']
                                );
                                
                                // Le retirer des rendez-vous à venir
                                _upcomingAppointments.remove(appointmentToCancel);
                                
                                // Modifier son statut et l'ajouter à l'historique
                                appointmentToCancel['status'] = 'Annulé';
                                _pastAppointments.insert(0, appointmentToCancel);
                              });
                              Navigator.pop(context); // Ferme la boîte de dialogue
                              Navigator.pop(context); // Ferme le bottom sheet
                            },
                            child: Text(
                              'Oui',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                  child: Text(
                    'Annuler le rendez-vous',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showRatingDialog(Map<String, dynamic> appointment) {
    double serviceRating = appointment['ratings']?['service']?.toDouble() ?? 0;
    double priceRating = appointment['ratings']?['price']?.toDouble() ?? 0;
    double cleanlinessRating = appointment['ratings']?['cleanliness']?.toDouble() ?? 0;
    double punctualityRating = appointment['ratings']?['punctuality']?.toDouble() ?? 0;
    _commentController.text = appointment['comment'] ?? '';
    _selectedPhotos = appointment['reviewPhotos']?.cast<String>() ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Noter ${appointment['professionalName']}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              
              // Qualité du service
              Text(
                'Qualité du service',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: List.generate(5, (index) => IconButton(
                  icon: Icon(
                    index < serviceRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => serviceRating = index + 1.0),
                )),
              ),
              
              // Ponctualité
              Text(
                'Ponctualité',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: List.generate(5, (index) => IconButton(
                  icon: Icon(
                    index < punctualityRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => punctualityRating = index + 1.0),
                )),
              ),
              
              // Rapport qualité/prix
              Text(
                'Rapport qualité/prix',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: List.generate(5, (index) => IconButton(
                  icon: Icon(
                    index < priceRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => priceRating = index + 1.0),
                )),
              ),
              
              // Propreté
              Text(
                'Propreté',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: List.generate(5, (index) => IconButton(
                  icon: Icon(
                    index < cleanlinessRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => cleanlinessRating = index + 1.0),
                )),
              ),
              
              // Commentaire
              SizedBox(height: 16.h),
              TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Ajouter un commentaire...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              
              // Photos
              SizedBox(height: 16.h),
              Row(
                children: [
                  ..._selectedPhotos!.map((photo) => Container(
                    width: 60.w,
                    height: 60.w,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: NetworkImage(photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )).toList(),
                  if (_selectedPhotos!.length < 5)
                    InkWell(
                      onTap: () {
                        // TODO: Implémenter la sélection de photos
                        setState(() {
                          _selectedPhotos!.add('https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=200&h=200&fit=crop');
                        });
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Icon(Icons.add_photo_alternate, color: Colors.grey),
                      ),
                    ),
                ],
              ),
              
              // Bouton de validation
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      appointment['ratings'] = {
                        'service': serviceRating,
                        'price': priceRating,
                        'cleanliness': cleanlinessRating,
                        'punctuality': punctualityRating,
                      };
                      appointment['rating'] = (serviceRating + priceRating + cleanlinessRating + punctualityRating) / 4;
                      appointment['comment'] = _commentController.text;
                      appointment['reviewPhotos'] = _selectedPhotos;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Enregistrer mon avis',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingCard(Map<String, dynamic> appointment) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(appointment['image']),
                  radius: 24.r,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['professionalName'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        appointment['service'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '${appointment['date']} ${appointment['time']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showRatingDialog(appointment),
                ),
              ],
            ),
            if (appointment['ratings'] != null) ...[
              SizedBox(height: 16.h),
              _buildRatingRow('Service', appointment['ratings']['service']),
              _buildRatingRow('Ponctualité', appointment['ratings']['punctuality']),
              _buildRatingRow('Prix', appointment['ratings']['price']),
              _buildRatingRow('Propreté', appointment['ratings']['cleanliness']),
              if (appointment['comment'] != null && appointment['comment'].isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(
                  appointment['comment'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[800],
                  ),
                ),
              ],
              if (appointment['reviewPhotos'] != null && appointment['reviewPhotos'].isNotEmpty) ...[
                SizedBox(height: 8.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: appointment['reviewPhotos'].map<Widget>((photo) => Container(
                      width: 80.w,
                      height: 80.w,
                      margin: EdgeInsets.only(right: 8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          image: NetworkImage(photo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ] else
              Center(
                child: TextButton(
                  onPressed: () => _showRatingDialog(appointment),
                  child: Text('Donner mon avis'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(String label, double rating) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
          Row(
            children: List.generate(5, (index) => Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 16.sp,
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24.sp,
          color: AppTheme.primaryColor,
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment, bool isPast) {
    final bool isRated = isPast && appointment['rating'] != null;
    
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () => _showAppointmentDetails(appointment, isPast),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(appointment['image']),
                    radius: 24.r,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment['professionalName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          appointment['service'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: _getStatusColor(appointment['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      appointment['status'],
                      style: TextStyle(
                        color: _getStatusColor(appointment['status']),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${appointment['date']} ${appointment['time']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  if (isRated)
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16.sp,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${appointment['rating']}/5',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      '${appointment['price'].toStringAsFixed(2)} €',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmé':
        return Colors.green;
      case 'En attente':
        return AppTheme.primaryColor;
      case 'Terminé':
        return Colors.grey;
      case 'Annulé':
        return Colors.red;
      default:
        return AppTheme.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes rendez-vous',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('À venir'),
                  if (_showNotificationBadge)
                    Container(
                      margin: EdgeInsets.only(left: 4.w),
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        _upcomingAppointments.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Tab(text: 'Historique'),
            Tab(text: 'Mes notes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Onglet des rendez-vous à venir
          ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: _upcomingAppointments.length,
            itemBuilder: (context, index) => _buildAppointmentCard(_upcomingAppointments[index], false),
          ),
          // Onglet de l'historique
          ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: _pastAppointments.length,
            itemBuilder: (context, index) => _buildAppointmentCard(_pastAppointments[index], true),
          ),
          // Onglet des notes
          ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: _pastAppointments.where((a) => a['status'] == 'Terminé').length,
            itemBuilder: (context, index) => _buildRatingCard(
              _pastAppointments.where((a) => a['status'] == 'Terminé').toList()[index],
            ),
          ),
        ],
      ),
    );
  }
}
