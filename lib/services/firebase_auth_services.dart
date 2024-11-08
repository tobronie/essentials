import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign up with phone number
  Future<User?> signUpWithPhone({
    required String phone,
    required BuildContext context,
  }) async {
    try {
      // Trigger phone authentication flow
      UserCredential userCredential = (await _firebaseAuth.signInWithPhoneNumber(phone)) as UserCredential;
      return userCredential.user;
    } catch (e) {
      _showErrorSnackBar(context, e);
      return null;
    }
  }

  // Sign in with phone number
  Future<User?> signInWithPhone({
    required String phone,
    required BuildContext context,
  }) async {
    try {
      // Trigger phone authentication flow
      UserCredential userCredential = (await _firebaseAuth.signInWithPhoneNumber(phone)) as UserCredential;
      return userCredential.user;
    } catch (e) {
      _showErrorSnackBar(context, e);
      return null;
    }
  }

  // Get current user phone number
  String? getCurrentUser() {
    try {
      User? user = _firebaseAuth.currentUser;
      return user?.phoneNumber;
    } catch (e) {
      print('Error getting current user: ${e.toString()}');
      return null;
    }
  }

  // Delete the current user
  static Future<void> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      print('Error deleting user: ${e.toString()}');
    }
  }

  // Helper function to display error messages in SnackBar
  void _showErrorSnackBar(BuildContext context, dynamic error) {
    final String errorMessage = error.toString();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }
}
