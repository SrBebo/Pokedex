import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    // Simulación de inicio de sesión exitoso
    await Future.delayed(Duration(seconds: 2));

    // Cambiar el estado de inicio de sesión
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
