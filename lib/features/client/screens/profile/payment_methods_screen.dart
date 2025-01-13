import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'visa',
      'number': '**** **** **** 4242',
      'expiry': '12/25',
      'isDefault': true,
    },
    {
      'type': 'mastercard',
      'number': '**** **** **** 5555',
      'expiry': '09/24',
      'isDefault': false,
    },
  ];

  IconData _getCardIcon(String type) {
    switch (type.toLowerCase()) {
      case 'visa':
        return FontAwesomeIcons.ccVisa;
      case 'mastercard':
        return FontAwesomeIcons.ccMastercard;
      case 'amex':
        return FontAwesomeIcons.ccAmex;
      default:
        return FontAwesomeIcons.creditCard;
    }
  }

  void _showAddCardDialog() {
    final numberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une carte'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: numberController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de carte',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom sur la carte',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expiryController,
                      decoration: const InputDecoration(
                        labelText: 'Date d\'expiration (MM/YY)',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
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
              setState(() {
                _paymentMethods.add({
                  'type': 'visa', // Simplified for demo
                  'number': '**** **** **** ${numberController.text.substring(max(0, numberController.text.length - 4))}',
                  'expiry': expiryController.text,
                  'isDefault': _paymentMethods.isEmpty,
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Ajouter'),
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
          'Moyens de paiement',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: _paymentMethods.length,
        itemBuilder: (context, index) {
          final method = _paymentMethods[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListTile(
              leading: Icon(
                _getCardIcon(method['type']),
                size: 32.w,
                color: AppTheme.primaryColor,
              ),
              title: Text(
                method['number'],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                'Expire le ${method['expiry']}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (method['isDefault'])
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Par défaut',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      if (!method['isDefault'])
                        const PopupMenuItem(
                          value: 'default',
                          child: Text('Définir par défaut'),
                        ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Supprimer'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'default') {
                        setState(() {
                          for (var m in _paymentMethods) {
                            m['isDefault'] = false;
                          }
                          method['isDefault'] = true;
                        });
                      } else if (value == 'delete') {
                        setState(() {
                          _paymentMethods.removeAt(index);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCardDialog,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

int max(int a, int b) {
  return a > b ? a : b;
}
