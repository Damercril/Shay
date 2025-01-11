import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class ProClientsTab extends StatefulWidget {
  const ProClientsTab({super.key});

  @override
  State<ProClientsTab> createState() => _ProClientsTabState();
}

class _ProClientsTabState extends State<ProClientsTab> {
  // TODO: Replace with actual client data
  final List<Map<String, dynamic>> clients = [
    {
      'name': 'Sophie Martin',
      'lastVisit': '2024-01-05',
      'totalVisits': 5,
      'favoriteService': 'Coiffure',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'revenue': 450.0,
      'loyaltyPoints': 120,
      'lastServices': ['Coupe', 'Coloration', 'Brushing'],
      'nextAppointment': '2024-01-20',
      'preferences': 'Préfère les rendez-vous le matin',
      'notes': 'Allergique à certains produits de coloration',
    },
    {
      'name': 'Marie Dubois',
      'lastVisit': '2024-01-03',
      'totalVisits': 3,
      'favoriteService': 'Manucure',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'revenue': 280.0,
      'loyaltyPoints': 75,
      'lastServices': ['Manucure', 'Pose de vernis'],
      'nextAppointment': '2024-01-25',
      'preferences': 'Aime les couleurs vives',
      'notes': 'Cliente fidèle, toujours ponctuelle',
    },
    {
      'name': 'Lucas Bernard',
      'lastVisit': '2024-01-02',
      'totalVisits': 8,
      'favoriteService': 'Coiffure',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'revenue': 720.0,
      'loyaltyPoints': 200,
      'lastServices': ['Coupe homme', 'Barbe'],
      'nextAppointment': '2024-01-15',
      'preferences': 'Préfère les rendez-vous en fin de journée',
      'notes': 'Client régulier, aime les coupes modernes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor,
                AppTheme.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
        title: Text(
          'Mes Clients',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 8,
        shadowColor: AppTheme.primaryColor.withOpacity(0.5),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filtering
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatisticsHeader(),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un client...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.grey.shade50,
                        ],
                      ),
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(client['avatar']),
                      ),
                      title: Text(
                        client['name'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text('Dernière visite: ${client['lastVisit']}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${client['revenue']}€',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${client['totalVisits']} visites',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow('Points fidélité', '${client['loyaltyPoints']} pts'),
                              _buildInfoRow('Prochain RDV', client['nextAppointment']),
                              _buildInfoRow('Service favori', client['favoriteService']),
                              _buildInfoRow('Derniers services', client['lastServices'].join(', ')),
                              _buildInfoRow('Préférences', client['preferences']),
                              _buildInfoRow('Notes', client['notes']),
                            ],
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.calendar_today),
                              label: const Text('Nouveau RDV'),
                              onPressed: () {
                                // TODO: Navigate to appointment creation
                              },
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.edit),
                              label: const Text('Modifier'),
                              onPressed: () {
                                // TODO: Navigate to client edit
                              },
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.history),
                              label: const Text('Historique'),
                              onPressed: () {
                                // TODO: Show client history
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor,
              AppTheme.primaryColor.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            // TODO: Navigate to add new client
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.person_add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildStatisticsHeader() {
    double totalRevenue = clients.fold(0, (sum, client) => sum + (client['revenue'] as double));
    int totalClients = clients.length;
    double averageRevenuePerClient = totalRevenue / totalClients;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.15),
            AppTheme.primaryColor.withOpacity(0.05),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'CA Total',
            '${totalRevenue.toStringAsFixed(0)}€',
            Icons.euro,
          ),
          _buildStatItem(
            'Clients',
            '$totalClients',
            Icons.people,
          ),
          _buildStatItem(
            'Moy/Client',
            '${averageRevenuePerClient.toStringAsFixed(0)}€',
            Icons.analytics,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryColor.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.primaryColor.withOpacity(0.8),
                  ],
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
