import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayniss/core/enums/user_type.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  UserType? _userType;
  final SharedPreferences _prefs;

  AuthProvider(this._prefs) {
    _loadUserState();
  }

  bool get isAuthenticated => _isAuthenticated;
  UserType? get userType => _userType;

  Future<void> _loadUserState() async {
    // TODO: Implémenter la logique de chargement de l'état de l'utilisateur
  }

  Future<void> loginWithPhone(String phone, String pin) async {
    // TODO: Implémenter la logique d'authentification avec le serveur
    await Future.delayed(const Duration(seconds: 2)); // Simuler une requête API

    _isAuthenticated = true;
    await _prefs.setString('isAuthenticated', 'true');
    notifyListeners();
  }

  Future<void> register(String phone, String pin, UserType userType) async {
    // TODO: Implémenter la logique d'inscription avec le serveur
    await Future.delayed(const Duration(seconds: 2)); // Simuler une requête API

    _isAuthenticated = true;
    _userType = userType;
    await _prefs.setString('userType', userType.toString());
    await _prefs.setString('isAuthenticated', 'true');
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _userType = null;
    _prefs.clear();
    notifyListeners();
  }
}
