import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUpWithPhone(
      {required String phone,
      required BuildContext context}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithPhone(phone: phone);
      return credential.user;
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }

  Future<User?> signInWithPhone(
      {required String phone,
      required BuildContext context}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithPhone(phone: phone);
      return credential.user;
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }

  String? getCurrentUser() {
    try {
      User? user = _firebaseAuth.currentUser;
      return user?.phone;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<void> deleteUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user!.delete();
  }
}

// percobaan

extension on FirebaseAuth {
  signInWithPhone({required String phone}) {}
  
  createUserWithPhone({required String phone}) {}
}

extension on User? {
  String? get phone => null;
}
