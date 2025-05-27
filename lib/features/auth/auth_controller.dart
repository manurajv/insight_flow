import 'package:flutter/material.dart';

import '../../core/services/auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService;

  AuthController(this._authService);

  Future<void> login(String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _authService.createUserWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }
}