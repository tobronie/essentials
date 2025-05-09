// import 'dart:io';
// import 'package:essentials/screens/navigation/activity_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:flutter/services.dart';

// class SKTMScreen extends StatefulWidget {
//   const SKTMScreen({super.key});

//   @override
//   _SKTMScreenState createState() => _SKTMScreenState();
// }

// class _SKTMScreenState extends State<SKTMScreen> {
//   File? selectedImageKTP;
//   File? selectedImageKK;

//   Future getImageKTP({bool fromCamera = false}) async {
//     final ImagePicker picker = ImagePicker();

//     final XFile? imagePicked = await picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (imagePicked != null) {
//       selectedImageKTP = File(imagePicked.path);
//       setState(() {});
//     }
//   }

//   Future getImageKK({bool fromCamera = false}) async {
//     final ImagePicker picker = ImagePicker();

//     final XFile? imagePicked = await picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (imagePicked != null) {
//       selectedImageKK = File(imagePicked.path);
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
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
//           'SKTM',
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
//         child: Container(
//           color: const Color(0xffF9F9F9),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _uploadKTP(),
//                 const SizedBox(height: 12),
//                 _uploadKK(),
//                 const SizedBox(height: 12),
//                 _formulir(),
//                 const SizedBox(height: 32),
//                 _uploadButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Column _uploadKTP() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               'Foto KTP Pemohon',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(width: 4),
//             Text(
//               '*',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.red,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         Container(
//           height: 78,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: Color(0xFFD9D9D9),
//               width: 2,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     selectedImageKTP != null
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: SizedBox(
//                               height: 74,
//                               width: MediaQuery.of(context).size.width,
//                               child:
//                                   Image.file(selectedImageKTP!, fit: BoxFit.cover),
//                             ),
//                           )
//                         : Container(),
//                     if (selectedImageKTP == null)
//                       TextButton(
//                         onPressed: () async {
//                           await getImageKTP();
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               PhosphorIconsRegular.fileArrowUp,
//                               color: Colors.black,
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               'Unggah foto disini',
//                               style: GoogleFonts.dmSans(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               if (selectedImageKTP != null)
//                 Positioned(
//                   bottom: 6,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedImageKTP = null;
//                         });
//                       },
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: const Icon(
//                             PhosphorIconsRegular.trash,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Column _uploadKK() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               'Foto Kartu Keluarga',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(width: 4),
//             Text(
//               '*',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.red,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         Container(
//           height: 78,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: Color(0xFFD9D9D9),
//               width: 2,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     selectedImageKK != null
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: SizedBox(
//                               height: 74,
//                               width: MediaQuery.of(context).size.width,
//                               child:
//                                   Image.file(selectedImageKK!, fit: BoxFit.cover),
//                             ),
//                           )
//                         : Container(),
//                     if (selectedImageKK == null)
//                       TextButton(
//                         onPressed: () async {
//                           await getImageKK();
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               PhosphorIconsRegular.fileArrowUp,
//                               color: Colors.black,
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               'Unggah foto disini',
//                               style: GoogleFonts.dmSans(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               if (selectedImageKK != null)
//                 Positioned(
//                   bottom: 6,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedImageKK = null;
//                         });
//                       },
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: const Icon(
//                             PhosphorIconsRegular.trash,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Column _formulir() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Nama Wali Keluarga',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   '*',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextField(
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   fontStyle: FontStyle.italic,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: "Nama sesuai KTP ...",
//                   hintStyle: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 11),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Nominal Pendapatan Wali perBulan',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   '*',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 42,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   fontStyle: FontStyle.italic,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: "Jumlah pendapatan keluarga ...",
//                   hintStyle: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 11),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Rincian Biaya Hidup',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   '*',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 142,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: const Color(0xffD9D9D9),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextFormField(
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   fontStyle: FontStyle.italic,
//                 ),
//                 maxLines: null,
//                 decoration: InputDecoration(
//                   hintText: "Isi dengan data yang benar...",
//                   hintStyle: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Container _uploadButton() {
//     return Container(
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF00AA13),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//           ),
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ActivityScreen()),
//           );
//         },
//         child: Text(
//           'Unggah Formulir',
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
