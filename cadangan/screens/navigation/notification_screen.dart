// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class NotifikasiScreen extends StatefulWidget {
//   const NotifikasiScreen({super.key});

//   @override
//   _NotifikasiScreenState createState() => _NotifikasiScreenState();
// }

// class _NotifikasiScreenState extends State<NotifikasiScreen> {
//   @override
//   void initState() {
//     super.initState();
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       print("User ID: ${user.uid}");
//     } else {
//       print("No user is currently logged in.");
//     }
//   }
  
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
//           'Notifikasi',
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
//             color: const Color(0xffF9F9F9),
//             padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 8),
//                 _data(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _data() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => NotifikasiDetailScreen()),
//             //   );
//           },
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pengajuan Anda telah berhasil dikirim. Harap tunggu persetujuan dari pejabat desa yang berwenang.',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.1,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Senin, 01 Juli 2024',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const Divider(
//           color: Color(0xffD9D9D9),
//         ),
//         GestureDetector(
//           onTap: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => NotifikasiDetailScreen()),
//             //   );
//           },
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pengajuan surat Domisili dari Imam Tobroni. Harap di verifikasi secepatnya.',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.1,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Senin, 01 Juli 2024',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const Divider(
//           color: Color(0xffD9D9D9),
//         ),
//         GestureDetector(
//           onTap: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => NotifikasiDetailScreen()),
//             //   );
//           },
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pelaporan dari Imam Tobroni atas Kerusakan Jl. Kalikening barat dekat warung harap di verifikasi',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.1,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Senin, 01 Juli 2024',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const Divider(
//           color: Color(0xffD9D9D9),
//         ),
//       ],
//     );
//   }
// }
