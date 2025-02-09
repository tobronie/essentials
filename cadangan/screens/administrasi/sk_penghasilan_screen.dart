// import 'dart:io';
// import 'package:essentials/screens/navigation/activity_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:flutter/services.dart';

// class PenghasilanScreen extends StatefulWidget {
//   const PenghasilanScreen({super.key});

//   @override
//   _PenghasilanScreenState createState() => _PenghasilanScreenState();
// }

// class _PenghasilanScreenState extends State<PenghasilanScreen> {
//   String? selectedPendapatanAyah;
//   String? selectedPendapatanIbu;
//   File? selectedImageKTP;
//   File? selectedImageKK;
//   File? selectedImageAyah;
//   File? selectedImageIbu;

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

//   Future getImageAyah({bool fromCamera = false}) async {
//     final ImagePicker picker = ImagePicker();

//     final XFile? imagePicked = await picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (imagePicked != null) {
//       selectedImageAyah = File(imagePicked.path);
//       setState(() {});
//     }
//   }

//   Future getImageIbu({bool fromCamera = false}) async {
//     final ImagePicker picker = ImagePicker();

//     final XFile? imagePicked = await picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (imagePicked != null) {
//       selectedImageIbu = File(imagePicked.path);
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
//           'Penghasilan Orang Tua',
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
//                 _formulirAyah(),
//                 const SizedBox(height: 12),
//                 _formulirIbu(),
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
//                               child: Image.file(selectedImageKTP!,
//                                   fit: BoxFit.cover),
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
//                               child: Image.file(selectedImageKK!,
//                                   fit: BoxFit.cover),
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
//         const SizedBox(height: 6),
//         const Divider(
//           color: Color(0xffD9D9D9),
//         ),
//       ],
//     );
//   }

//   Column _formulirAyah() {
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
//             Row(
//               children: [
//                 Text(
//                   'Pekerjaan',
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
//                   hintText: "Pekerjaan umum anda ...",
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
//                   'Pendapatan perBulan',
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
//             GestureDetector(
//               child: Container(
//                 height: 42,
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: const Color(0xffD9D9D9),
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     value: selectedPendapatanAyah,
//                     hint: Text(
//                       'Belum memilih',
//                       style: GoogleFonts.montserrat(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black,
//                       ),
//                     ),
//                     items: <String>[
//                       '0',
//                       '< Rp 1.000.000,-',
//                       'Rp 1.000.000,- sampai Rp 2.500.000,-',
//                       'Rp 2.500.000,- sampai Rp 5.000.000,-',
//                       'Rp 5.000.000,- sampai Rp 10.000.000,-',
//                       '> Rp 10.000.000,-'
//                     ].map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedPendapatanAyah = newValue;
//                       });
//                     },
//                     isExpanded: true,
//                     icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                     dropdownColor: Color(0xffF9F9F9),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Pendukung Penghasilan (Opsional)',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 78,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: Color(0xFFD9D9D9),
//                   width: 2,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         selectedImageAyah != null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: SizedBox(
//                                   height: 74,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Image.file(selectedImageAyah!,
//                                       fit: BoxFit.cover),
//                                 ),
//                               )
//                             : Container(),
//                         if (selectedImageAyah == null)
//                           TextButton(
//                             onPressed: () async {
//                               await getImageAyah();
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   PhosphorIconsRegular.fileArrowUp,
//                                   color: Colors.black,
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   'Unggah foto disini',
//                                   style: GoogleFonts.dmSans(
//                                     fontSize: 14,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   if (selectedImageAyah != null)
//                     Positioned(
//                       bottom: 6,
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedImageAyah = null;
//                             });
//                           },
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Center(
//                               child: const Icon(
//                                 PhosphorIconsRegular.trash,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               'NPWP atau bukti penghasilan dari tempat bekerja',
//               style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 height: 1.2,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 6),
//         const Divider(
//           color: Color(0xffD9D9D9),
//         ),
//       ],
//     );
//   }

//   Column _formulirIbu() {
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
//             Row(
//               children: [
//                 Text(
//                   'Pekerjaan',
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
//                   hintText: "Pekerjaan umum anda ...",
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
//                   'Pendapatan perBulan',
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
//             GestureDetector(
//               child: Container(
//                 height: 42,
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: const Color(0xffD9D9D9),
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     value: selectedPendapatanIbu,
//                     hint: Text(
//                       'Belum memilih',
//                       style: GoogleFonts.montserrat(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black,
//                       ),
//                     ),
//                     items: <String>[
//                       '0',
//                       '< Rp 1.000.000,-',
//                       'Rp 1.000.000,- sampai Rp 2.500.000,-',
//                       'Rp 2.500.000,- sampai Rp 5.000.000,-',
//                       'Rp 5.000.000,- sampai Rp 10.000.000,-',
//                       '> Rp 10.000.000,-'
//                     ].map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedPendapatanIbu = newValue;
//                       });
//                     },
//                     isExpanded: true,
//                     icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//                     dropdownColor: Color(0xffF9F9F9),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Foto Pendukung Penghasilan (Opsional)',
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Container(
//               height: 78,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: Color(0xFFD9D9D9),
//                   width: 2,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         selectedImageIbu != null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: SizedBox(
//                                   height: 74,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Image.file(selectedImageIbu!,
//                                       fit: BoxFit.cover),
//                                 ),
//                               )
//                             : Container(),
//                         if (selectedImageIbu == null)
//                           TextButton(
//                             onPressed: () async {
//                               await getImageIbu();
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   PhosphorIconsRegular.fileArrowUp,
//                                   color: Colors.black,
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   'Unggah foto disini',
//                                   style: GoogleFonts.dmSans(
//                                     fontSize: 14,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   if (selectedImageIbu != null)
//                     Positioned(
//                       bottom: 6,
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedImageIbu = null;
//                             });
//                           },
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Center(
//                               child: const Icon(
//                                 PhosphorIconsRegular.trash,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               'NPWP atau bukti penghasilan dari tempat bekerja',
//               style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 height: 1.2,
//                 color: Colors.black,
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
