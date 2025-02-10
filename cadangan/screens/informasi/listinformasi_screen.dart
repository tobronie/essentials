// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essentials/screens/informasi/detailinformasi_screen.dart';
// import 'package:essentials/services/information_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';

// class InformasiScreen extends StatefulWidget {
//   @override
//   _InformasiScreenState createState() => _InformasiScreenState();
// }

// class _InformasiScreenState extends State<InformasiScreen> {
//   String _selectedOption = 'Semua';
//   TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   bool _isSearchActive = false;
//   FocusNode _searchFocusNode = FocusNode();

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
//           'Informasi',
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
//                 _search(),
//                 const SizedBox(height: 18),
//                 _option(context),
//                 const SizedBox(height: 18),
//                 _data(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _search() {
//     return Container(
//       height: 40,
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: Color(0xffD9D9D9),
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(50),
//       ),
//       child: Row(
//         children: [
//           Icon(PhosphorIconsRegular.magnifyingGlass, color: Color(0xff00AA13)),
//           SizedBox(width: 12),
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               focusNode: _searchFocusNode,
//               style: GoogleFonts.montserrat(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black,
//               ),
//               onChanged: (query) {
//                 setState(() {
//                   _searchQuery = query;
//                   _isSearchActive = query.isNotEmpty;
//                   if (_isSearchActive) {
//                     _selectedOption = 'Semua';
//                   }
//                 });
//               },
//               onTap: () {
//                 setState(() {
//                   _isSearchActive = true;
//                   _selectedOption = 'Semua';
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: "Pencarian Anda ...",
//                 hintStyle: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 11),
//               ),
//             ),
//           ),
//           SizedBox(width: 4),
//         ],
//       ),
//     );
//   }

//   Widget _option(BuildContext context) {
//     return Container(
//       height: 36,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           _buildCategoryOption('Semua'),
//           if (!_isSearchActive) ...[
//             _buildCategoryOption('Infrastruktur'),
//             _buildCategoryOption('Kecelakaan'),
//             _buildCategoryOption('Kegiatan'),
//             _buildCategoryOption('Sosial'),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryOption(String category) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedOption = category;
//           _searchQuery = '';
//           _isSearchActive = false;
//           _searchController.clear();
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.only(right: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//         decoration: BoxDecoration(
//           color: _selectedOption == category
//               ? Color(0xff00AA13).withOpacity(0.25)
//               : Colors.white,
//           border: Border.all(
//             color: _selectedOption == category
//                 ? Color(0xff00AA13)
//                 : Color(0xffD9D9D9),
//             width: 1,
//           ),
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Text(
//           category,
//           style: GoogleFonts.montserrat(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color:
//                 _selectedOption == category ? Color(0xff00AA13) : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _data() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: DbInformation.getDataByCategoryAndSearch(
//                 _selectedOption, _searchQuery),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final documents = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: documents.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot information = documents[index];

//                     return Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => InformasiDetailScreen(
//                                   information: information.data()
//                                       as Map<String, dynamic>,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             width: double.infinity,
//                             height: 92,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 8),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           information['judul'] ?? '',
//                                           style: GoogleFonts.montserrat(
//                                             fontSize: 16,
//                                             height: 1.1,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.black,
//                                           ),
//                                           maxLines: 3,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           information['tgl_upload'] != null
//                                               ? DateFormat('dd MMM yyyy')
//                                                   .format(
//                                                   (information['tgl_upload']
//                                                           as Timestamp)
//                                                       .toDate(),
//                                                 )
//                                               : 'Tanggal tidak tersedia',
//                                           style: GoogleFonts.montserrat(
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Container(
//                                       width: 76,
//                                       height: 76,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         image: DecorationImage(
//                                           image: NetworkImage(
//                                             information['image'] ?? '',
//                                           ),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 2),
//                         SizedBox(
//                           height: 1,
//                           child: Container(
//                             color: Color(0xffD9D9D9),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text("Error: ${snapshot.error}"),
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
