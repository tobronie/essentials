// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/gestures.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DesaKedungmulyoScreen extends StatefulWidget {
//   const DesaKedungmulyoScreen({super.key});

//   @override
//   _DesaKedungmulyoScreenState createState() => _DesaKedungmulyoScreenState();
// }

// class _DesaKedungmulyoScreenState extends State<DesaKedungmulyoScreen> {
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
//                   image: AssetImage('assets/images/desa_a.png'),
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
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 3,
//                       width: 40,
//                       color: Color(0xff00AA13),
//                     ),
//                     const SizedBox(height: 32),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Align(
//                           alignment: AlignmentDirectional.centerStart,
//                           child: Text(
//                             'Desa Kedungmulyo',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 18,
//                               height: 1.2,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.justify,
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Align(
//                               child: Text(
//                                 'Update',
//                                 style: GoogleFonts.montserrat(
//                                   fontSize: 10,
//                                   height: 1.2,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               child: Text(
//                                 '2024',
//                                 style: GoogleFonts.montserrat(
//                                   fontSize: 10,
//                                   height: 1.2,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff00AA13),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Text(
//                         'kec. Bangilan, kab. Tuban, Jawa Timur',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 10,
//                           height: 1.2,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Text(
//                         'Desa Kedungmulyo merupakan salah satu desa yang berada di Kecamatan Bangilan, Kabupaten Tuban, Jawa Timur. Secara geografis, Desa Kedungmulyo terletak di dataran rendah dengan ketinggian wilayah yang relatif datar. Jarak antara desa ini dengan pusat Kecamatan Bangilan adalah ±2 km, sedangkan jaraknya dari ibu kota Kabupaten Tuban adalah sekitar 58 km. Desa ini memiliki luas wilayah sebesar 3,88 km² yang terdiri dari 6 dusun, yaitu Dusun Gembong, Pereng, Kedungasri, Jatimulyo, Geneng, dan Gomang.',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.2,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Text(
//                         'Jumlah Penduduk dan Demografi: Desa Kedungmulyo dihuni oleh sekitar 3.987 jiwa yang tersebar dalam 826 kepala keluarga (KK). Komposisi penduduk desa ini mayoritas berprofesi sebagai petani. Hal ini didukung oleh kondisi alam Desa Kedungmulyo yang memiliki lahan persawahan seluas 253,29 hektar serta lahan perkebunan seluas 13,70 hektar. Selain itu, beberapa penduduk terlibat dalam sektor peternakan dengan memelihara sapi, kambing, dan ayam. Profesi lainnya yang ada di desa ini mencakup wiraswasta, guru, serta pegawai negeri sipil (PNS).',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.2,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.asset(
//                         'assets/images/peta.png',
//                         width: double.infinity,
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Batasan wilayah:',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               height: 1.2,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             '• Sebelah utara dengan Desa Banjarworo',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               height: 1.2,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.justify,
//                           ),
//                           Text(
//                             '• Sebelah selatan dengan Desa Kedungharjo',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               height: 1.2,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.justify,
//                           ),
//                           Text(
//                             '• Sebelah timur dengan Desa Lajo Kidul',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               height: 1.2,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.justify,
//                           ),
//                           Text(
//                             '• Sebelah barat dengan Desa Bangilan',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               height: 1.2,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.justify,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Text(
//                         'Desa Kedungmulyo memiliki potensi besar di sektor pertanian dengan padi sebagai komoditas utama yang tidak hanya mencukupi kebutuhan lokal tetapi juga dipasarkan keluar. Selain padi, masyarakat juga menanam palawija dan tanaman hortikultura serta beternak sapi, kambing, dan ayam untuk menambah pendapatan. Warga juga aktif dalam usaha kecil menengah (UKM) di bidang perdagangan dan jasa. Fasilitas umum seperti sekolah dasar, Puskesmas Pembantu, dan infrastruktur jalan yang sudah diaspal memudahkan mobilitas dan keseharian warga. Desa ini juga teraliri listrik dan memiliki akses air bersih, mendukung upaya pengembangan ekonomi lokal yang berfokus pada pertanian dan peternakan."',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.2,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Text(
//                         'Adapun dokumentasi Desa Kedungmulyo, dapat dilihat sebagai berikut:',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           height: 1.2,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: 142,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           // Item 1 horizontal
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 2, right: 12, top: 2),
//                             child: Container(
//                               width: 214,
//                               height: 142,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     blurRadius: 3,
//                                     spreadRadius: 0,
//                                   ),
//                                 ],
//                               ),
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Image.asset(
//                                       'assets/images/test.jpg',
//                                       width: 214,
//                                       height: 142,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Item 2 horizontal
//                           Padding(
//                             padding: const EdgeInsets.only(right: 12, top: 2),
//                             child: Container(
//                               width: 214,
//                               height: 142,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     blurRadius: 3,
//                                     spreadRadius: 0,
//                                   ),
//                                 ],
//                               ),
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Image.asset(
//                                       'assets/images/test_2.jpg',
//                                       width: 214,
//                                       height: 142,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Item 3 horizontal
//                           Padding(
//                             padding: const EdgeInsets.only(right: 12, top: 2),
//                             child: Container(
//                               width: 214,
//                               height: 142,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     blurRadius: 3,
//                                     spreadRadius: 0,
//                                   ),
//                                 ],
//                               ),
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Image.asset(
//                                       'assets/images/test_3.jpg',
//                                       width: 214,
//                                       height: 142,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Item 3 horizontal
//                           Padding(
//                             padding: const EdgeInsets.only(right: 12, top: 2),
//                             child: Container(
//                               width: 214,
//                               height: 142,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     blurRadius: 3,
//                                     spreadRadius: 0,
//                                   ),
//                                 ],
//                               ),
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Image.asset(
//                                       'assets/images/desa_b.png',
//                                       width: 214,
//                                       height: 142,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: RichText(
//                         text: TextSpan(
//                           style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             height: 1.2,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black,
//                           ),
//                           children: [
//                             TextSpan(
//                               text:
//                                   'Untuk informasi lebih lengkapnya mengenai Desa Kedungmulyo, dapat mengunjungi website resmi Desa Kedungmulyo, Kecamatan Tuban: ',
//                             ),
//                             TextSpan(
//                               text: 'http://kedungmulyo-bangilan.desa.id/',
//                               style: TextStyle(
//                                 color: const Color(0xFF5E28FF),
//                                 decoration: TextDecoration.underline,
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () async {
//                                   final url =
//                                       'http://kedungmulyo-bangilan.desa.id/';
//                                   if (await canLaunch(url)) {
//                                     await launch(url);
//                                   } else {
//                                     throw 'Could not launch $url';
//                                   }
//                                 },
//                             ),
//                           ],
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
