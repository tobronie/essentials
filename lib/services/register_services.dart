import 'package:essentials/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterService {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register(String phone, BuildContext context) async {
    User? user = await _authService.signUpWithPhone(
      phone: phone,
      context: context,
    );

    if (user != null) {
      // Menyimpan data pengguna ke koleksi 'user' di Firestore
      await _firestore.collection('user').doc(user.uid).set({
        'uid': user.uid,
        'no_hp': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran Akun Berhasil'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, '/otp');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran Akun Gagal'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
