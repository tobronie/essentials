// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProblemInformasiScreen extends StatefulWidget {
//   const ProblemInformasiScreen({super.key});

//   @override
//   _ProblemInformasiScreenState createState() => _ProblemInformasiScreenState();
// }

// class _ProblemInformasiScreenState extends State<ProblemInformasiScreen> {
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
//           'Masalah fitur informasi',
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
//                   'Fitur informasi dalam aplikasi essentials berfungsi sebagai sumber pengetahuan bagi pengguna mengenai layanan, kebijakan, dan prosedur yang berlaku. Namun, banyak pengguna yang mengalami kesulitan dalam menemukan informasi yang relevan, disebabkan oleh kurangnya organisasi dan navigasi yang jelas dalam aplikasi. Ketidakjelasan dalam kategori informasi dan minimnya fitur pencarian membuat pengguna merasa frustrasi ketika mencari data yang mereka butuhkan. Situasi ini dapat menyebabkan kebingungan dan ketidakpuasan, yang pada akhirnya mengurangi pengalaman pengguna secara keseluruhan.',
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
//                   'Untuk mengatasi masalah ini, penting bagi tim pengembang untuk merombak struktur informasi dalam aplikasi. Mengimplementasikan sistem pengelompokan informasi yang lebih baik dan memperkenalkan fitur pencarian yang efisien akan sangat membantu pengguna dalam menemukan informasi yang mereka cari. Selain itu, menyertakan ringkasan atau deskripsi singkat untuk setiap kategori informasi dapat membantu pengguna memahami dengan cepat apa yang dapat mereka temukan di dalamnya. Penggunaan ikon atau label yang intuitif juga dapat memudahkan navigasi, sehingga pengguna tidak perlu membuang waktu untuk menjelajahi menu yang tidak relevan.',
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
//                   'Selain perbaikan pada antarmuka, menyediakan informasi yang lebih interaktif dan mudah dicerna, seperti video tutorial atau FAQ (Frequently Asked Questions), dapat sangat bermanfaat. Dengan menambahkan elemen visual dan interaktif, pengguna dapat dengan mudah memahami konsep-konsep penting tanpa harus membaca teks panjang. Memberikan akses ke sumber daya tambahan, seperti forum pengguna atau chat langsung dengan dukungan pelanggan, juga dapat membantu pengguna mendapatkan jawaban atas pertanyaan mereka dengan cepat. Dengan langkah-langkah ini, diharapkan fitur informasi dapat lebih memenuhi kebutuhan pengguna dan meningkatkan kepuasan mereka terhadap aplikasi essentials.',
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
