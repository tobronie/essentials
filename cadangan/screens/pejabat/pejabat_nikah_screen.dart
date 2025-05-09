// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essentials/screens/pejabat/listadministrasi_pejabat_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:flutter/services.dart';

// class Pejabat_NikahScreen extends StatefulWidget {
//   final String id;
//   const Pejabat_NikahScreen({Key? key, required this.id}) : super(key: key);

//   @override
//   _Pejabat_NikahScreenState createState() => _Pejabat_NikahScreenState();
// }

// class _Pejabat_NikahScreenState extends State<Pejabat_NikahScreen> {
//   bool _isImageVisibleKTPPria = false;
//   bool _isImageVisibleAktePria = false;
//   bool _isImageVisibleKKPria = false;
//   bool _isImageVisibleNikahAyahPria = false;
//   bool _isImageVisibleNikahIbuPria = false;
//   bool _isImageVisibleFormulirPria = false;
//   bool _isImageVisibleKTPWanita = false;
//   bool _isImageVisibleAkteWanita = false;
//   bool _isImageVisibleKKWanita = false;
//   bool _isImageVisibleNikahAyahWanita = false;
//   bool _isImageVisibleNikahIbuWanita = false;
//   bool _isImageVisibleFormulirWanita = false;
//   Map<String, dynamic>? data;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       print("User ID: ${user.uid}");
//     } else {
//       print("No user is currently logged in.");
//     }
//     fetchData();
//   }

//   void fetchData() async {
//     try {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('nikah')
//           .doc(widget.id)
//           .get();

//       if (snapshot.exists) {
//         setState(() {
//           data = snapshot.data() as Map<String, dynamic>?;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//       setState(() {
//         isLoading = false;
//       });
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
//           'Verifikasi Pernikahan',
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
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : data == null
//                 ? const Center(child: Text('Data tidak ditemukan'))
//                 : Container(
//                     color: const Color(0xffF9F9F9),
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 18, horizontal: 18),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           _dataPengajuan(),
//                           const SizedBox(height: 8),
//                           _biodataPria(),
//                           const SizedBox(height: 24),
//                           _biodataWanita(),
//                           const SizedBox(height: 24),
//                           const Divider(
//                             color: Color(0xffD9D9D9),
//                           ),
//                           const SizedBox(height: 24),
//                           _dataAkun(),
//                           const SizedBox(height: 42),
//                           _konfirmasi(),
//                         ],
//                       ),
//                     ),
//                   ),
//       ),
//     );
//   }

//   Column _dataPengajuan() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Data Pengajuan:',
//               style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF616161),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Column _biodataPria() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Biodata Calon Mempelai Pria:',
//               style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF616161),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 6),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto KTP',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_ktp_pria'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleKTPPria
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKTPPria = !_isImageVisibleKTPPria;
//                       });
//                       _showDialogFotoKTPPria(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Akte Kelahiran',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_akte_pria'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleAktePria
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleAktePria = !_isImageVisibleAktePria;
//                       });
//                       _showDialogFotoAktePria(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Kartu Keluarga',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_kk_pria'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleKKPria
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKKPria = !_isImageVisibleKKPria;
//                       });
//                       _showDialogFotoKKPria(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Buku Nikah Ayah',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_nikah_ayah_pria'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleNikahAyahPria
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleNikahAyahPria = !_isImageVisibleNikahAyahPria;
//                       });
//                       _showDialogFotoNikahAyahPria(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Buku Nikah Ibu',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_nikah_ibu_pria'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleNikahIbuPria
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleNikahIbuPria = !_isImageVisibleNikahIbuPria;
//                       });
//                       _showDialogFotoNikahIbuPria(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Formulir Calon Pria',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_formulir_pria'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleFormulirPria
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleFormulirPria = !_isImageVisibleFormulirPria;
//                       });
//                       _showDialogFotoFormulirPria(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Column _biodataWanita() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Biodata Calon Mempelai Wanita:',
//               style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF616161),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 6),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto KTP',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_ktp_wanita'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleKTPWanita
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKTPWanita = !_isImageVisibleKTPWanita;
//                       });
//                       _showDialogFotoKTPWanita(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Akte Kelahiran',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_akte_wanita'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleAkteWanita
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleAkteWanita = !_isImageVisibleAkteWanita;
//                       });
//                       _showDialogFotoAkteWanita(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Kartu Keluarga',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_kk_wanita'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleKKWanita
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKKWanita = !_isImageVisibleKKWanita;
//                       });
//                       _showDialogFotoKKWanita(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Buku Nikah Ayah',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_nikah_ayah_wanita'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleNikahAyahWanita
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleNikahAyahWanita = !_isImageVisibleNikahAyahWanita;
//                       });
//                       _showDialogFotoNikahAyahWanita(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Buku Nikah Ibu',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_nikah_ibu_wanita'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleNikahIbuWanita
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleNikahIbuWanita = !_isImageVisibleNikahIbuWanita;
//                       });
//                       _showDialogFotoNikahIbuWanita(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Formulir Calon Wanita',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 2, left: 8, top: 8, bottom: 8),
//                       child: Row(
//                         children: [
//                           Icon(
//                             PhosphorIcons.file(),
//                             color: Colors.black.withOpacity(0.7),
//                             size: 22,
//                           ),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data?['foto_formulir_wanita'] ?? '',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isImageVisibleFormulirWanita
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleFormulirWanita = !_isImageVisibleFormulirWanita;
//                       });
//                       _showDialogFotoFormulirWanita(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Column _dataAkun() {
//     String FormatUpload = '';
//     if (data != null && data!['tgl_upload'] != null) {
//       Timestamp timestamp = data!['tgl_upload'];
//       DateTime date = timestamp.toDate();
//       FormatUpload = DateFormat('dd MMMM yyyy - HH:mm').format(date);
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Data Akun:',
//               style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF616161),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Nama Pemohon',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 data?['nama'] ?? '',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.left,
//                 overflow: TextOverflow.visible,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'No Handphone',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 data?['no_hp'] ?? '',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.left,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Email',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 data?['email'] ?? '',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.left,
//                 overflow: TextOverflow.visible,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Waktu Pengajuan',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 FormatUpload,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.left,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   void _showDialogFotoKTPPria(BuildContext context) {
//     if (_isImageVisibleKTPPria) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_ktp_pria'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKTPPria = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoKTPWanita(BuildContext context) {
//     if (_isImageVisibleKTPWanita) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_ktp_wanita'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKTPWanita = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoAktePria(BuildContext context) {
//     if (_isImageVisibleAktePria) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_akte_pria'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleAktePria = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoAkteWanita(BuildContext context) {
//     if (_isImageVisibleAkteWanita) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_akte_wanita'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleAkteWanita = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoKKPria(BuildContext context) {
//     if (_isImageVisibleKKPria) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_kk_pria'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKKPria = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoKKWanita(BuildContext context) {
//     if (_isImageVisibleKKWanita) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_kk_wanita'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKKWanita = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoNikahAyahPria(BuildContext context) {
//     if (_isImageVisibleNikahAyahPria) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_nikah_ayah_pria'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleNikahAyahPria = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoNikahAyahWanita(BuildContext context) {
//     if (_isImageVisibleNikahAyahWanita) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_nikah_ayah_wanita'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleNikahAyahWanita = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoNikahIbuPria(BuildContext context) {
//     if (_isImageVisibleNikahIbuPria) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_nikah_ibu_pria'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleNikahIbuPria = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoNikahIbuWanita(BuildContext context) {
//     if (_isImageVisibleNikahIbuWanita) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_nikah_ibu_wanita'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleNikahIbuWanita = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoFormulirPria(BuildContext context) {
//     if (_isImageVisibleFormulirPria) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_formulir_pria'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleFormulirPria = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoFormulirWanita(BuildContext context) {
//     if (_isImageVisibleFormulirWanita) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['foto_formulir_wanita'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleFormulirWanita = false;
//         });
//       });
//     }
//   }

//   Row _konfirmasi() {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             margin: const EdgeInsets.only(right: 6),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFF0004),
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ListVerifikasiPejabatScreen()),
//                 );
//               },
//               child: Text(
//                 'Tidak Disetujui',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             margin: const EdgeInsets.only(left: 6),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff00AA13),
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ListVerifikasiPejabatScreen()),
//                 );
//               },
//               child: Text(
//                 'Setuju',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
