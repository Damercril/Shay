import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayniss/core/enums/user_type.dart';
import 'package:shayniss/features/auth/models/register_professional_request.dart';

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
    if (_prefs.getBool('rememberMe') == true) {
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
    } else {
      _isAuthenticated = false;
      _userType = UserType.client;
    }
    notifyListeners();
  }

  Future<void> loginWithPhone(String phone, String pin, {bool rememberMe = false}) async {
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
    await _prefs.setBool('rememberMe', rememberMe);
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

  Future<void> registerProfessional({
    required RegisterProfessionalRequest professional,
    required String pin,
  }) async {
    try {
      // D'abord créer le compte avec le téléphone et le PIN
      await register(
        professional.phone,
        pin,
        userType: UserType.professional,
      );

      // Ensuite sauvegarder les informations supplémentaires du professionnel
      await _saveAdditionalProfessionalInfo(professional);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveAdditionalProfessionalInfo(RegisterProfessionalRequest professional) async {
    // TODO: Implémenter la sauvegarde des informations supplémentaires
    // Cette méthode devrait envoyer les données au backend
    await Future.delayed(const Duration(seconds: 1)); // Simulation
  }

  void logout() {
    _isAuthenticated = false;
    _userType = UserType.client;
    if (_prefs.getBool('rememberMe') != true) {
      _prefs.clear();
    }
    notifyListeners();
  }

  // Méthode pour basculer explicitement vers un compte professionnel
  Future<void> switchToProfessional() async {
    _userType = UserType.professional;
    await _prefs.setString('userType', _userType.toString());
    notifyListeners();
  }
}
