// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essentials/screens/admin/listlaporan_admin_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';

// class DataVerifikasiLaporanScreen extends StatefulWidget {
//   final String id;
//   const DataVerifikasiLaporanScreen({Key? key, required this.id})
//       : super(key: key);

//   @override
//   _DataVerifikasiLaporanScreenState createState() =>
//       _DataVerifikasiLaporanScreenState();
// }

// class _DataVerifikasiLaporanScreenState
//     extends State<DataVerifikasiLaporanScreen> {
//   bool _isImageVisible = false;
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
//           .collection('pelaporan')
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
//           'Verifikasi Data Pengaduan',
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
//                           _namaPelapor(),
//                           const SizedBox(height: 12),
//                           _tglUpload(),
//                           const SizedBox(height: 12),
//                           _image(),
//                           const SizedBox(height: 12),
//                           _data(),
//                           const SizedBox(height: 24),
//                           _verification(),
//                         ],
//                       ),
//                     ),
//                   ),
//       ),
//     );
//   }

//   Column _namaPelapor() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Nama Pengadu',
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
//                 // data?['nama'] ?? '',
//                 'Nama sementara',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   fontStyle: FontStyle.italic,
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

//   Column _tglUpload() {
//     String formatUpload = '';
//     if (data != null && data!['tgl_upload'] != null) {
//       Timestamp timestamp = data!['tgl_upload'];
//       DateTime date = timestamp.toDate();
//       formatUpload = DateFormat('dd MMMM yyyy - HH:mm').format(date);
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Waktu Pengaduan',
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
//                 formatUpload,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Column _image() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Foto Kejadian',
//           style: GoogleFonts.montserrat(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Container(
//           height: 42,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(
//               color: const Color(0xffD9D9D9),
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       right: 2, left: 8, top: 8, bottom: 8),
//                   child: Row(
//                     children: [
//                       Icon(
//                         PhosphorIcons.file(),
//                         color: Colors.black.withOpacity(0.7),
//                         size: 22,
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           data?['image'] ?? '',
//                           style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black,
//                           ),
//                           textAlign: TextAlign.left,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(
//                   _isImageVisible
//                       ? PhosphorIcons.eye()
//                       : PhosphorIcons.eyeSlash(),
//                   color: Colors.black,
//                   size: 24,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _isImageVisible = !_isImageVisible;
//                   });
//                   _showImageDialog(context);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _showImageDialog(BuildContext context) {
//     if (_isImageVisible) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               minScale: 0.1,
//               maxScale: 5.0,
//               child: Image.network(
//                 data?['image'] ?? '',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       ).then((_) {
//         setState(() {
//           _isImageVisible = false;
//         });
//       });
//     }
//   }

//   Column _data() {
//     String FormatWaktuKejadian = '';
//     if (data != null && data!['tgl_upload'] != null) {
//       Timestamp timestamp = data!['tgl_upload'];
//       DateTime date = timestamp.toDate();
//       FormatWaktuKejadian = DateFormat('dd MMMM yyyy - HH:mm').format(date);
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Judul Pengaduan',
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
//                 data?['judul'] ?? '',
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
//               'Waktu Kejadian',
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
//                 FormatWaktuKejadian,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Lokasi Kejadian',
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
//                 data?['lokasi'] ?? '',
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
//               'Isi Pengaduan',
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
//                 data?['isi'] ?? '',
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
//       ],
//     );
//   }

//   Container _verification() {
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
//                 builder: (context) => ListVerifikasiLaporanAdminScreen()),
//           );
//         },
//         child: Text(
//           'Verifikasi Pengaduan',
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
