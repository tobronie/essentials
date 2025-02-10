// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essentials/screens/admin/listadministrasi_admin_screen.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:flutter/services.dart';

// class Admin_AkteScreen extends StatefulWidget {
//   final String id;
//   const Admin_AkteScreen({Key? key, required this.id}) : super(key: key);

//   @override
//   _Admin_AkteScreenState createState() => _Admin_AkteScreenState();
// }

// class _Admin_AkteScreenState extends State<Admin_AkteScreen> {
//   File? selectedDocument;
//   bool _isImageVisibleKelahiran = false;
//   bool _isImageVisibleKK = false;
//   bool _isImageVisibleKTPAyah = false;
//   bool _isImageVisibleNikahAyah = false;
//   bool _isImageVisibleKTPIbu = false;
//   bool _isImageVisibleNikahIbu = false;
//   bool _isImageVisibleKTPSaksi1 = false;
//   bool _isImageVisibleKTPSaksi2 = false;
//   bool _isImageVisibleAkteSaudara = false;
//   bool _isImageVisibleIjasah = false;
//   Map<String, dynamic>? data;
//   bool isLoading = true;

//   Future<void> pickDocument() async {
//     final FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'docx'],
//     );

//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         selectedDocument = File(result.files.single.path!);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No file selected or an error occurred'),
//         ),
//       );
//     }
//   }

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
//           .collection('akte')
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
//           'Verifikasi Akte Kelahiran',
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
//                           _imageSuartKelahiran(),
//                           const SizedBox(height: 8),
//                           _imageKK(),
//                           const SizedBox(height: 24),
//                           _biodataAyah(),
//                           const SizedBox(height: 24),
//                           _biodataIbu(),
//                           const SizedBox(height: 24),
//                           _dataSaksi(),
//                           const SizedBox(height: 24),
//                           _dataPendukung(),
//                           const SizedBox(height: 24),
//                           const Divider(
//                             color: Color(0xffD9D9D9),
//                           ),
//                           const SizedBox(height: 24),
//                           _dataAkun(),
//                           const SizedBox(height: 24),
//                           const Divider(
//                             color: Color(0xffD9D9D9),
//                           ),
//                           const SizedBox(height: 24),
//                           _verifikasiKepalaDesa(),
//                           const SizedBox(height: 12),
//                           _uploadDocument(),
//                           const SizedBox(height: 32),
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

//   Column _imageSuartKelahiran() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Dokumen Kelahiran',
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
//                               data?['surat_kelahiran'] ?? '',
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
//                       _isImageVisibleKelahiran
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKelahiran = !_isImageVisibleKelahiran;
//                       });
//                       _showDialogSuratKelahiran(context);
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

//   Column _imageKK() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
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
//                               data?['foto_kk'] ?? '',
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
//                       _isImageVisibleKK
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKK = !_isImageVisibleKK;
//                       });
//                       _showDialogFotoKK(context);
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

//   Column _biodataAyah() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Biodata Ayah:',
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
//                               data?['foto_ktp_ayah'] ?? '',
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
//                       _isImageVisibleKTPAyah
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKTPAyah = !_isImageVisibleKTPAyah;
//                       });
//                       _showDialogFotoKTPAyah(context);
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
//               'Foto Buku Nikah',
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
//                               data?['foto_nikah_ayah'] ?? '',
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
//                       _isImageVisibleNikahAyah
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleNikahAyah = !_isImageVisibleNikahAyah;
//                       });
//                       _showDialogFotoNikahAyah(context);
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

//   Column _biodataIbu() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Biodata Ibu:',
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
//                               data?['foto_ktp_ibu'] ?? '',
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
//                       _isImageVisibleKTPIbu
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKTPIbu = !_isImageVisibleKTPIbu;
//                       });
//                       _showDialogFotoKTPIbu(context);
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
//               'Foto Buku Nikah',
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
//                               data?['foto_nikah_ibu'] ?? '',
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
//                       _isImageVisibleNikahIbu
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleNikahIbu = !_isImageVisibleNikahIbu;
//                       });
//                       _showDialogFotoNikahIbu(context);
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

//   Column _dataSaksi() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Saksi Kelahiran:',
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
//               'Foto KTP Saksi 1',
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
//                               data?['foto_ktp_saksi_satu'] ?? '',
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
//                       _isImageVisibleKTPSaksi1
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKTPSaksi1 = !_isImageVisibleKTPSaksi1;
//                       });
//                       _showDialogFotoKTPSaksiSatu(context);
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
//               'Foto KTP Saksi 2',
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
//                               data?['foto_ktp_saksi_dua'] ?? '',
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
//                       _isImageVisibleKTPSaksi2
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKTPSaksi2 = !_isImageVisibleKTPSaksi2;
//                       });
//                       _showDialogFotoKTPSaksiDua(context);
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

//   Column _dataPendukung() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Dokumen Pendukung:',
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
//               'Foto Akte Kelahiran Saudara',
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
//               child: data?['foto_akte_saudara'] != null &&
//                       data!['foto_akte_saudara'].isNotEmpty
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 right: 2, left: 8, top: 8, bottom: 8),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   PhosphorIcons.file(),
//                                   color: Colors.black.withOpacity(0.7),
//                                   size: 22,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     data?['foto_akte_saudara'] ??
//                                         '',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.black,
//                                     ),
//                                     textAlign: TextAlign.left,
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             _isImageVisibleAkteSaudara
//                                 ? PhosphorIcons.eye()
//                                 : PhosphorIcons.eyeSlash(),
//                             color: Colors.black,
//                             size: 24,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isImageVisibleAkteSaudara =
//                                   !_isImageVisibleAkteSaudara;
//                             });
//                             _showDialogFotoAkteSaudara(context);
//                           },
//                         ),
//                       ],
//                     )
//                   : Center(
//                       child: Text(
//                         "Foto tidak tersedia",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red.withOpacity(0.8),
//                         ),
//                       ),
//                     ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Ijasah Bersangkutan',
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
//               child: data?['foto_ijasah_bersangkutan'] != null &&
//                       data!['foto_ijasah_bersangkutan'].isNotEmpty
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 right: 2, left: 8, top: 8, bottom: 8),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   PhosphorIcons.file(),
//                                   color: Colors.black.withOpacity(0.7),
//                                   size: 22,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     data!['foto_ijasah_bersangkutan'],
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.black,
//                                     ),
//                                     textAlign: TextAlign.left,
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             _isImageVisibleIjasah
//                                 ? PhosphorIcons.eye()
//                                 : PhosphorIcons.eyeSlash(),
//                             color: Colors.black,
//                             size: 24,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isImageVisibleIjasah = !_isImageVisibleIjasah;
//                             });
//                             _showDialogFotoIjasahBersangkutan(context);
//                           },
//                         ),
//                       ],
//                     )
//                   : Center(
//                       child: Text(
//                         "Foto tidak tersedia",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red.withOpacity(0.8),
//                         ),
//                       ),
//                     ),
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

//   void _showDialogSuratKelahiran(BuildContext context) {
//     if (_isImageVisibleKelahiran) {
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
//                 data?['surat_kelahiran'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKelahiran = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoKK(BuildContext context) {
//     if (_isImageVisibleKK) {
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
//                 data?['foto_kk'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKK = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoKTPAyah(BuildContext context) {
//     if (_isImageVisibleKTPAyah) {
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
//                 data?['foto_ktp_ayah'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKTPAyah = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoNikahAyah(BuildContext context) {
//     if (_isImageVisibleNikahAyah) {
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
//                 data?['foto_nikah_ayah'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleNikahAyah = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoKTPIbu(BuildContext context) {
//     if (_isImageVisibleKTPIbu) {
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
//                 data?['foto_ktp_ibu'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKTPIbu = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoNikahIbu(BuildContext context) {
//     if (_isImageVisibleNikahIbu) {
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
//                 data?['foto_nikah_ibu'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleNikahIbu = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoKTPSaksiSatu(BuildContext context) {
//     if (_isImageVisibleKTPSaksi1) {
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
//                 data?['foto_ktp_saksi_satu'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKTPSaksi1 = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoKTPSaksiDua(BuildContext context) {
//     if (_isImageVisibleKTPSaksi2) {
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
//                 data?['foto_ktp_saksi_dua'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKTPSaksi2 = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoAkteSaudara(BuildContext context) {
//     if (_isImageVisibleAkteSaudara) {
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
//                 data?['foto_akte_saudara'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleAkteSaudara = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoIjasahBersangkutan(BuildContext context) {
//     if (_isImageVisibleIjasah) {
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
//                 data?['foto_ijasah_bersangkutan'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleIjasah = false;
//         });
//       });
//     }
//   }

//   Container _verifikasiKepalaDesa() {
//     return Container(
//       child: Text.rich(
//         TextSpan(
//           children: [
//             TextSpan(
//               text: 'Telah disetujui',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 height: 1.1,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xff00AA13),
//               ),
//             ),
//             TextSpan(text: ' '),
//             TextSpan(
//               text: 'Kepala Desa Bpk. Hj. Ahmad Fulan, S.H, M.Sos',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 height: 1.1,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         textAlign: TextAlign.left,
//       ),
//     );
//   }

//   Column _uploadDocument() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 52,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: const Color(0xFFD9D9D9),
//               width: 2,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           if (selectedDocument != null)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   const Icon(
//                                     Icons.description,
//                                     color: Colors.black,
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: Text(
//                                       selectedDocument!.path.split('/').last,
//                                       style: GoogleFonts.dmSans(
//                                         fontSize: 14,
//                                         color: Colors.black,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           if (selectedDocument == null)
//                             TextButton(
//                               onPressed: () async {
//                                 await pickDocument();
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     PhosphorIconsRegular.fileArrowUp,
//                                     color: Colors.black,
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Text(
//                                     'Unggah Dokumen di sini',
//                                     style: GoogleFonts.dmSans(
//                                       fontSize: 14,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   if (selectedDocument != null)
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: IconButton(
//                         icon: const Icon(
//                           PhosphorIconsRegular.trash,
//                           color: Colors.red,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             selectedDocument = null;
//                           });
//                         },
//                       ),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Container _konfirmasi() {
//     return Container(
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF0D0140),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//           ),
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ListVerifikasiAdministrasiAdminScreen()),
//           );
//         },
//         child: Text(
//           'Konfirmasi',
//           style: GoogleFonts.montserrat(
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
