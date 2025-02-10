// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProblemAkunScreen extends StatefulWidget {
//   const ProblemAkunScreen({super.key});

//   @override
//   _ProblemAkunScreenState createState() => _ProblemAkunScreenState();
// }

// class _ProblemAkunScreenState extends State<ProblemAkunScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF9F9F9),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black,),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text(
//           'Masalah pada akun',
//           style: GoogleFonts.montserrat(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//         backgroundColor: Color(0xffF9F9F9),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Pengguna aplikasi essentials sering mengalami masalah terkait akun, yang dapat mengganggu pengalaman penggunaan mereka. Salah satu masalah yang umum adalah kesulitan dalam proses masuk ke akun. Hal ini bisa disebabkan oleh penggunaan kata sandi yang salah, atau akun yang terkunci setelah beberapa kali percobaan masuk yang gagal. Situasi seperti ini dapat menyebabkan frustrasi, terutama jika pengguna membutuhkan akses cepat ke fitur-fitur penting dalam aplikasi.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Untuk mengatasi masalah masuk, pengguna disarankan untuk memanfaatkan opsi “Lupa Kata Sandi” yang tersedia di halaman masuk. Dengan mengklik tautan tersebut, pengguna akan diminta untuk memasukkan alamat email atau nomor telepon yang terdaftar. Setelah itu, mereka akan menerima instruksi untuk mereset kata sandi melalui email atau SMS. Proses ini dirancang untuk memastikan keamanan akun, sehingga pengguna dapat dengan mudah mendapatkan kembali akses tanpa harus membuat akun baru.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Selain itu, ada kalanya pengguna menghadapi masalah akun yang lebih serius, seperti akun yang terkunci. Hal ini biasanya terjadi setelah beberapa upaya masuk yang gagal dalam waktu singkat. Dalam situasi seperti ini, pengguna disarankan untuk menunggu beberapa saat sebelum mencoba masuk kembali. Jika akun masih terkunci setelah menunggu, penting untuk menghubungi layanan pelanggan aplikasi. Tim dukungan akan dapat membantu pengguna memulihkan akses dengan melakukan verifikasi identitas yang sesuai.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Penting juga bagi pengguna untuk memastikan bahwa informasi akun mereka, seperti alamat email dan nomor telepon, selalu diperbarui. Ini akan memudahkan proses pemulihan akun jika mereka menghadapi masalah di kemudian hari. Dengan mengikuti langkah-langkah pencegahan ini dan memanfaatkan opsi yang tersedia, pengguna dapat mengatasi berbagai masalah terkait akun dengan lebih efektif dan kembali menggunakan aplikasi essentials dengan lancar.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
