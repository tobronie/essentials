// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:share_plus/share_plus.dart';

// class InformasiTetapScreen extends StatefulWidget {
//   final Map<String, dynamic> informationDesa;

//   const InformasiTetapScreen({required this.informationDesa, Key? key}) : super(key: key);

//   @override
//   _InformasiTetapScreenState createState() => _InformasiTetapScreenState();
// }

// class _InformasiTetapScreenState extends State<InformasiTetapScreen> {
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
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(left: 0),
//             child: IconButton(
//               icon: const Icon(
//                 PhosphorIconsRegular.arrowBendUpRight,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 final String shareContent =
//                     '${widget.informationDesa['image']}\n${widget.informationDesa['judul']}\n\nInformasi Selengkapnya di Aplikasi "Essentials" Masyarakat Ds. Kedungmulyo, Kec. Bangilan, Kab. Tuban';
//                 Share.share(shareContent);
//               },
//             ),
//           ),
//         ],
//         elevation: 0,
//         backgroundColor: Color(0xffF9F9F9),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               height: 240,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(widget.informationDesa['image'] ?? ''),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 padding: const EdgeInsets.only(
//                     left: 18, right: 18, top: 8, bottom: 24),
//                 margin: const EdgeInsets.only(top: 216),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(25)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 3,
//                       width: 40,
//                       color: const Color(0xff00AA13),
//                     ),
//                     const SizedBox(height: 32),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Text(
//                         widget.informationDesa['judul'] ?? '',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 18,
//                           height: 1.2,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Align(
//                       alignment: AlignmentDirectional.centerEnd,
//                       child: Container(
//                         height: 2,
//                         width: 118,
//                         color: const Color(0xffD9D9D9),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Align(
//                       alignment: AlignmentDirectional.centerEnd,
//                       child: Text(
//                         widget.informationDesa['update'] ?? '',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.2,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Text(
//                         widget.informationDesa['isi'] ?? '',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.2,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
