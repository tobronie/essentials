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
      // Mengaktifkan verifikasi nomor telepon
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Autentikasi otomatis berhasil
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Menampilkan pesan kesalahan
          _showErrorSnackBar(context, e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Mengirimkan verificationId ke layar OTP untuk verifikasi kode
          Navigator.pushNamed(context, '/otp', arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Jika kode OTP habis waktu
          _showErrorSnackBar(context, 'Kode OTP telah habis waktu');
        },
      );
      // Mengambil user yang sedang login setelah verifikasi selesai
      User? user = _firebaseAuth.currentUser;
      return user;
    } catch (e) {
      _showErrorSnackBar(context, e.toString());
      return null;
    }
  }

  // Sign in with phone number
  Future<User?> signInWithPhone({
    required String verificationId,
    required String smsCode,
    required BuildContext context,
  }) async {
    try {
      // Membuat credential dari verificationId dan smsCode
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Login dengan credential
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      _showErrorSnackBar(context, e.toString());
      return null;
    }
  }

  // Mendapatkan nomor telepon pengguna saat ini
  String? getCurrentUserPhone() {
    try {
      User? user = _firebaseAuth.currentUser;
      return user?.phoneNumber;
    } catch (e) {
      print('Terjadi kesalahan saat mendapatkan akun saat ini: ${e.toString()}');
      return null;
    }
  }

  // Menghapus pengguna saat ini
  static Future<void> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      print('Terjadi kesalahan saat menghapus akun: ${e.toString()}');
    }
  }

  // Fungsi bantu untuk menampilkan pesan error di SnackBar
  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }
}
