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

// class Admin_TanahScreen extends StatefulWidget {
//   final String id;
//   const Admin_TanahScreen({Key? key, required this.id}) : super(key: key);

//   @override
//   _Admin_TanahScreenState createState() => _Admin_TanahScreenState();
// }

// class _Admin_TanahScreenState extends State<Admin_TanahScreen> {
//   File? selectedDocument;
//   bool _isImageVisibleKTP = false;
//   bool _isImageVisibleKK = false;
//   bool _isImageVisibleSPPT = false;
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
//           .collection('tanah')
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
//           'Verifikasi Harga Tanah',
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
//                           _imageKTP(),
//                           const SizedBox(height: 12),
//                           _imageKK(),
//                           const SizedBox(height: 12),
//                           _imageSPPT_SHM(),
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

//   Column _imageKTP() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto KTP Pemohon',
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
//                               data?['foto_ktp'] ?? '',
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
//                       _isImageVisibleKTP
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleKTP = !_isImageVisibleKTP;
//                       });
//                       _showDialogFotoKTP(context);
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

//   Column _imageSPPT_SHM() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto SPPT atau SHM',
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
//                               data?['foto_sppt_shm'] ?? '',
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
//                       _isImageVisibleSPPT
//                           ? PhosphorIcons.eye()
//                           : PhosphorIcons.eyeSlash(),
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isImageVisibleSPPT = !_isImageVisibleSPPT;
//                       });
//                       _showDialogFotoSPPT(context);
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

//   void _showDialogFotoKTP(BuildContext context) {
//     if (_isImageVisibleKTP) {
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
//                 data?['foto_ktp'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleKTP = false;
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

//   void _showDialogFotoSPPT(BuildContext context) {
//     if (_isImageVisibleSPPT) {
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
//                 data?['foto_sppt_shm'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisibleSPPT = false;
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
