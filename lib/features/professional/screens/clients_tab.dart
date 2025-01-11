import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/custom_button.dart';
import '../models/professional.dart';
import '../models/client.dart';

class ClientsTab extends StatelessWidget {
  final Professional professional;

  const ClientsTab({
    Key? key,
    required this.professional,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Temporary mock data for clients
    final List<Client> clients = [
      Client(
        id: '1',
        name: 'Sophie Martin',
        email: 'sophie.martin@email.com',
        phoneNumber: '+33 6 12 34 56 78',
        lastAppointment: DateTime.now().subtract(const Duration(days: 5)),
        totalAppointments: 3,
      ),
      Client(
        id: '2',
        name: 'Lucas Bernard',
        email: 'lucas.bernard@email.com',
        phoneNumber: '+33 6 98 76 54 32',
        lastAppointment: DateTime.now().subtract(const Duration(days: 2)),
        totalAppointments: 5,
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.r),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un client...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
          ),

          // Clients list
          Expanded(
            child: ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        client.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    title: Text(client.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(client.email),
                        Text(client.phoneNumber),
                        Text(
                          'Dernier RDV: ${_formatDate(client.lastAppointment)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      '${client.totalAppointments} RDV',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // TODO: Navigate to client details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new client
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
