// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essentials/screens/pejabat/listadministrasi_pejabat_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:flutter/services.dart';

// class Pejabat_KKScreen extends StatefulWidget {
//   final String id;
//   const Pejabat_KKScreen({Key? key, required this.id}) : super(key: key);

//   @override
//   _Pejabat_KKScreenState createState() => _Pejabat_KKScreenState();
// }

// class _Pejabat_KKScreenState extends State<Pejabat_KKScreen> {
//   bool _isImageVisibleKKAsli = false;
//   bool _isImageVisibleNikahAyah = false;
//   bool _isImageVisibleNikahIbu = false;
//   bool _isImageVisibleIjasahKeluarga = false;
//   bool _isImageVisibleAkteKeluarga = false;
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
//           .collection('kk')
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
//           'Verifikasi KK',
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
//                           _imageKK(),
//                           const SizedBox(height: 12),
//                           _imageNikahAyah(),
//                           const SizedBox(height: 12),
//                           _imageNikahIbu(),
//                           const SizedBox(height: 12),
//                           _imageIjasahKeluarga(),
//                           const SizedBox(height: 12),
//                           _imageAkteKeluarga(),
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

//   Column _imageKK() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto KK Asli/Lama',
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
//               child: data?['foto_kk'] != null && data!['foto_kk'].isNotEmpty
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
//                                     data?['foto_kk'] ?? '',
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
//                             _isImageVisibleKKAsli
//                                 ? PhosphorIcons.eye()
//                                 : PhosphorIcons.eyeSlash(),
//                             color: Colors.black,
//                             size: 24,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isImageVisibleKKAsli = !_isImageVisibleKKAsli;
//                             });
//                             _showDialogFotoKKAsli(context);
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

//   Column _imageNikahAyah() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
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

//   Column _imageNikahIbu() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
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

//   Column _imageIjasahKeluarga() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Ijasah Seluruh Keluarga',
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
//                               data?['foto_ijasah_keluarga'] ?? '',
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
//                       _isImageVisibleIjasahKeluarga
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleIjasahKeluarga = !_isImageVisibleIjasahKeluarga;
//                       });
//                       _showDialogFotoIjasahKeluarga(context);
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

//   Column _imageAkteKeluarga() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Akte Seluruh Keluarga',
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
//                               data?['foto_akte_keluarga'] ?? '',
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
//                       _isImageVisibleAkteKeluarga
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleAkteKeluarga = !_isImageVisibleAkteKeluarga;
//                       });
//                       _showDialogFotoAkteKeluarga(context);
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

//   void _showDialogFotoKKAsli(BuildContext context) {
//     if (_isImageVisibleKKAsli) {
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
//           _isImageVisibleKKAsli = false;
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

//   void _showDialogFotoAkteKeluarga(BuildContext context) {
//     if (_isImageVisibleAkteKeluarga) {
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
//                 data?['foto_akte_keluarga'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleAkteKeluarga = false;
//         });
//       });
//     }
//   }

//   void _showDialogFotoIjasahKeluarga(BuildContext context) {
//     if (_isImageVisibleIjasahKeluarga) {
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
//                 data?['foto_ijasah_keluarga'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleIjasahKeluarga = false;
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
