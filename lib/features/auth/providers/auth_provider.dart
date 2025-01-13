import 'package:flutter/material.dart';
import 'package:shayniss/core/enums/user_type.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  UserType _userType = UserType.client;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  UserType get userType => _userType;
  String? get token => _token;

  Future<void> register(String phone, String pin, {required UserType userType}) async {
    // TODO: Implement registration logic with backend
    _isAuthenticated = true;
    _userType = userType;
    _token = 'dummy_token'; // Replace with actual token from backend
    notifyListeners();
  }

  Future<void> login(String phone, String pin) async {
    // TODO: Implement login logic with backend
    _isAuthenticated = true;
    _token = 'dummy_token'; // Replace with actual token from backend
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _token = null;
    notifyListeners();
  }
}
