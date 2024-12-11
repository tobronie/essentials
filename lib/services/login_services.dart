import 'package:essentials/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginServices {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<void> login(
      String email, String password, BuildContext context) async {
    User? user = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
      context: context,
    );

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil Masuk'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagl Masuk'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
