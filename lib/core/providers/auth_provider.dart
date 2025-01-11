import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayniss/core/enums/user_type.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  UserType _userType = UserType.client;
  final SharedPreferences _prefs;

  // Numéro de téléphone professionnel prédéfini
  static const String professionalPhone = '0652262798';

  AuthProvider(this._prefs) {
    _loadUserState();
  }

  bool get isAuthenticated => _isAuthenticated;
  UserType get userType => _userType;

  Future<void> _loadUserState() async {
    _isAuthenticated = _prefs.getString('isAuthenticated') == 'true';
    final userTypeStr = _prefs.getString('userType');
    if (userTypeStr != null) {
      try {
        _userType = UserType.values.firstWhere(
          (e) => e.toString() == userTypeStr,
          orElse: () => UserType.client,
        );
      } catch (e) {
        _userType = UserType.client;
      }
    } else {
      _userType = UserType.client;
      await _prefs.setString('userType', _userType.toString());
    }
    notifyListeners();
  }

  Future<void> loginWithPhone(String phone, String pin) async {
    await Future.delayed(const Duration(seconds: 2)); // Simuler une requête API

    // Si c'est le numéro professionnel, on définit le type professionnel
    // Sinon, par défaut c'est un client
    _userType = (phone == professionalPhone) 
        ? UserType.professional 
        : UserType.client;

    _isAuthenticated = true;
    await _prefs.setString('userType', _userType.toString());
    await _prefs.setString('isAuthenticated', 'true');
    await _prefs.setString('phone', phone);
    notifyListeners();
  }

  Future<void> register(String phone, String pin, {UserType? userType}) async {
    await Future.delayed(const Duration(seconds: 2)); // Simuler une requête API

    // Pour l'inscription, même logique que la connexion
    _userType = (phone == professionalPhone) 
        ? UserType.professional 
        : UserType.client;

    _isAuthenticated = true;
    await _prefs.setString('userType', _userType.toString());
    await _prefs.setString('isAuthenticated', 'true');
    await _prefs.setString('phone', phone);
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _userType = UserType.client;
    _prefs.clear();
    notifyListeners();
  }

  // Méthode pour basculer explicitement vers un compte professionnel
  Future<void> switchToProfessional() async {
    _userType = UserType.professional;
    await _prefs.setString('userType', _userType.toString());
    notifyListeners();
  }
}
