// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class FirebaseAuthService {
//   final _firebaseAuth = FirebaseAuth.instance;

//   Future<User?> signUpWithEmailAndPassword(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       UserCredential credential = await _firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       return credential.user;
//     } catch (e) {
//       final String errorMessage = e.toString();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMessage),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//     return null;
//   }

//   Future<User?> signInWithEmailAndPassword(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       UserCredential credential = await _firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: password);
//       return credential.user;
//     } catch (e) {
//       final String errorMessage = e.toString();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMessage),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//     return null;
//   }

//   Future logout() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   Future<bool> isLoggedIn() async{
//     var user = FirebaseAuth.instance.currentUser;
//     return user != null;
//   }

//   String? getCurrentUser() {
//     try {
//       User? user = _firebaseAuth.currentUser;
//       return user?.email;
//     } catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }
// }
