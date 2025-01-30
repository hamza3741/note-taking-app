import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;

  AuthViewModel() {
    // Listen to authentication state changes
    _auth.authStateChanges().listen((user) {
      currentUser = user;
      notifyListeners();
    });
  }

  get user => currentUser;

  Future<void> signup(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      currentUser = userCredential.user;
      notifyListeners();
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      currentUser = userCredential.user;
      notifyListeners();
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await _auth.signOut();
      currentUser = null;
      notifyListeners();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }
}
