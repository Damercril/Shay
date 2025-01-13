import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _biometricEnabled = true;
  bool _twoFactorEnabled = false;

  void _showChangePasswordDialog() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer le mot de passe'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe actuel',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Nouveau mot de passe',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirmer le nouveau mot de passe',
                ),
                obscureText: true,
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
              // Validate and change password
              if (newPasswordController.text == confirmPasswordController.text) {
                // Change password logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mot de passe modifié avec succès'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Les mots de passe ne correspondent pas'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Changer'),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption({
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _show2FADialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Double authentification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _twoFactorEnabled
                  ? 'Voulez-vous désactiver la double authentification ?'
                  : 'Voulez-vous activer la double authentification ?',
              style: TextStyle(fontSize: 16.sp),
            ),
            if (!_twoFactorEnabled) ...[
              SizedBox(height: 16.h),
              Text(
                'Un code de vérification vous sera envoyé par SMS à chaque connexion.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _twoFactorEnabled = !_twoFactorEnabled;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _twoFactorEnabled
                        ? 'Double authentification activée'
                        : 'Double authentification désactivée',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(_twoFactorEnabled ? 'Désactiver' : 'Activer'),
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
          'Sécurité',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Authentification',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _buildSecurityOption(
                  title: 'Changer le mot de passe',
                  subtitle: 'Modifier votre mot de passe actuel',
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                  onTap: _showChangePasswordDialog,
                ),
                Divider(height: 1, color: Colors.grey[200]),
                _buildSecurityOption(
                  title: 'Double authentification',
                  subtitle: _twoFactorEnabled
                      ? 'Activée'
                      : 'Désactivée',
                  trailing: Switch(
                    value: _twoFactorEnabled,
                    onChanged: (value) {
                      _show2FADialog();
                    },
                    activeColor: AppTheme.primaryColor,
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200]),
                _buildSecurityOption(
                  title: 'Authentification biométrique',
                  subtitle: _biometricEnabled
                      ? 'Activée'
                      : 'Désactivée',
                  trailing: Switch(
                    value: _biometricEnabled,
                    onChanged: (value) {
                      setState(() {
                        _biometricEnabled = value;
                      });
                    },
                    activeColor: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Appareils connectés',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.phone_android, color: AppTheme.primaryColor),
                  title: const Text('iPhone 13'),
                  subtitle: Text(
                    'Dernière connexion: Aujourd\'hui',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Déconnecter l'appareil
                    },
                    child: const Text('Déconnecter'),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200]),
                ListTile(
                  leading: Icon(Icons.laptop_mac, color: AppTheme.primaryColor),
                  title: const Text('MacBook Pro'),
                  subtitle: Text(
                    'Dernière connexion: Hier',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Déconnecter l'appareil
                    },
                    child: const Text('Déconnecter'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
