// ignore_for_file: use_build_context_synchronously

import 'package:essentials/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterService {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<void> register(
      String phone, BuildContext context) async {
    User? user = await _authService.signUpWithPhone(
      phone: phone,
      context: context,
    );

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User is successfully created'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, '/navigation');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create user'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
