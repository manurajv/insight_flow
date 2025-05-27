import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  bool get isAuthenticated => _user != null;
  User? get user => _user;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw FirebaseAuthException(
        code: 'unknown-error',
        message: 'An unknown error occurred',
      );
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw FirebaseAuthException(
        code: 'unknown-error',
        message: 'An unknown error occurred',
      );
    }
  }

  FirebaseAuthException _handleAuthException(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'invalid-email':
        message = 'The email address is badly formatted';
        break;
      case 'user-disabled':
        message = 'This user has been disabled';
        break;
      case 'user-not-found':
        message = 'No user found with this email';
        break;
      case 'wrong-password':
        message = 'Incorrect password';
        break;
      case 'email-already-in-use':
        message = 'This email is already in use';
        break;
      case 'operation-not-allowed':
        message = 'Email/password accounts are not enabled';
        break;
      case 'weak-password':
        message = 'Password is too weak';
        break;
      default:
        message = 'An unknown authentication error occurred';
    }
    return FirebaseAuthException(code: e.code, message: message);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}