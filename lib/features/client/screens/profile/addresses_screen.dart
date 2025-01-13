import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final List<Map<String, String>> _addresses = [
    {
      'type': 'Domicile',
      'address': '123 Rue de la Paix',
      'complement': 'Appartement 4B',
      'city': 'Paris',
      'postalCode': '75001',
    },
    {
      'type': 'Bureau',
      'address': '45 Avenue des Champs-Élysées',
      'complement': 'Étage 3',
      'city': 'Paris',
      'postalCode': '75008',
    },
  ];

  void _showAddEditAddressDialog([Map<String, String>? address]) {
    final isEditing = address != null;
    final typeController = TextEditingController(text: address?['type'] ?? '');
    final addressController = TextEditingController(text: address?['address'] ?? '');
    final complementController = TextEditingController(text: address?['complement'] ?? '');
    final cityController = TextEditingController(text: address?['city'] ?? '');
    final postalCodeController = TextEditingController(text: address?['postalCode'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Modifier l\'adresse' : 'Ajouter une adresse'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: typeController,
                decoration: const InputDecoration(
                  labelText: 'Type (ex: Domicile, Bureau)',
                ),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Adresse',
                ),
              ),
              TextField(
                controller: complementController,
                decoration: const InputDecoration(
                  labelText: 'Complément d\'adresse',
                ),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'Ville',
                ),
              ),
              TextField(
                controller: postalCodeController,
                decoration: const InputDecoration(
                  labelText: 'Code postal',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              final newAddress = {
                'type': typeController.text,
                'address': addressController.text,
                'complement': complementController.text,
                'city': cityController.text,
                'postalCode': postalCodeController.text,
              };

              setState(() {
                if (isEditing) {
                  final index = _addresses.indexOf(address);
                  _addresses[index] = newAddress;
                } else {
                  _addresses.add(newAddress);
                }
              });

              Navigator.pop(context);
            },
            child: Text(isEditing ? 'Modifier' : 'Ajouter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes adresses',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: _addresses.length,
        itemBuilder: (context, index) {
          final address = _addresses[index];
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        address['type']!,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showAddEditAddressDialog(address),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _addresses.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    address['address']!,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  if (address['complement']!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      address['complement']!,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                  SizedBox(height: 4.h),
                  Text(
                    '${address['postalCode']} ${address['city']}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditAddressDialog(),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
