// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essentials/screens/administrasi/listadministrasi_screen.dart';
// import 'package:essentials/screens/informasi/detailinformasi_screen.dart';
// import 'package:essentials/screens/informasi/informasitetap.dart';
// import 'package:essentials/screens/informasi/listinformasi_screen.dart';
// import 'package:essentials/screens/navigation/notification_screen.dart';
// import 'package:essentials/screens/pelaporan/formulirpelaporan_screen.dart';
// import 'package:essentials/services/information_desa_services.dart';
// import 'package:essentials/services/information_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:essentials/screens/navigation/navigation.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ScrollController scrollController = ScrollController();
//   int activeIndex = 0;
//   final double itemWidth = 274.0;

//   @override
//   void initState() {
//     super.initState();
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       print("User ID: ${user.uid}");
//     } else {
//       print("No user is currently logged in.");
//     }
//     scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     scrollController.removeListener(_onScroll);
//     scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     double currentScrollPosition = scrollController.position.pixels;
//     int newIndex = (currentScrollPosition / itemWidth).round();
//     if (newIndex < 0) newIndex = 0;
//     if (newIndex > 5) newIndex = 5;
//     if (newIndex != activeIndex) {
//       setState(() {
//         activeIndex = newIndex;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF9F9F9),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               height: 382,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xff00AA13).withOpacity(0.3),
//                     Colors.transparent,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: 4),
//                     _appBar(),
//                     const SizedBox(height: 18),
//                     _welcomeBanner(),
//                     const SizedBox(height: 18),
//                     _homeMenu(context),
//                     const SizedBox(height: 18),
//                     _homeInformasi(),
//                     const SizedBox(height: 18),
//                     _homeDesa(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomNavigationBar(selectedIndex: 0),
//     );
//   }

//   Widget _appBar() {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Selamat Datang\nWarga Kedungmulyo",
//             style: GoogleFonts.montserrat(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//               height: 1.2,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//               color: Color(0xff00AA13),
//               borderRadius: BorderRadius.circular(50),
//             ),
//             child: Center(
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => NotifikasiScreen()),
//                   );
//                 },
//                 child: const Icon(
//                   PhosphorIconsRegular.bell,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _welcomeBanner() {
//     return Container(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.asset(
//           'assets/images/home.png',
//           width: double.infinity,
//           fit: BoxFit.fitWidth,
//         ),
//       ),
//     );
//   }

//   Widget _homeMenu(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PelaporanScreen()),
//               );
//             },
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/icon_laporan.png',
//                   width: 70,
//                   height: 70,
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Pengaduan',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AdministrasiScreen()),
//               );
//             },
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/icon_administrasi.png',
//                   width: 70,
//                   height: 70,
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Administrasi',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => InformasiScreen()),
//               );
//             },
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/icon_informasi.png',
//                   width: 70,
//                   height: 70,
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Informasi',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _homeInformasi() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Cek informasi menarik lainnya',
//           style: GoogleFonts.montserrat(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 12),
//         StreamBuilder<QuerySnapshot>(
//           stream: DbInformation.getData(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final documents = snapshot.data!.docs;
//               final maxCount = documents.length > 5 ? 5 : documents.length;

//               return Column(
//                 children: [
//                   SizedBox(
//                     height: 156,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: maxCount,
//                       controller: scrollController,
//                       itemBuilder: (context, index) {
//                         DocumentSnapshot information = documents[index];
//                         return Padding(
//                           padding:
//                               const EdgeInsets.only(left: 2, right: 12, top: 2),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => InformasiDetailScreen(
//                                     information: information.data()
//                                         as Map<String, dynamic>,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               width: 274,
//                               height: 152,
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
//                                     child: Image.network(
//                                       information['image'] ?? '',
//                                       width: 274,
//                                       height: 152,
//                                       fit: BoxFit.cover,
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return const Icon(Icons.error);
//                                       },
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     top: 0,
//                                     child: Container(
//                                       width: 152,
//                                       height: 152,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.95),
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(18),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               information['kategori'] ?? '',
//                                               style: GoogleFonts.montserrat(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             Text(
//                                               information['judul'] ?? '',
//                                               style: GoogleFonts.montserrat(
//                                                 fontSize: 12,
//                                                 height: 1.2,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black,
//                                               ),
//                                               textAlign: TextAlign.justify,
//                                             ),
//                                             const SizedBox(height: 12),
//                                             Align(
//                                               alignment: AlignmentDirectional
//                                                   .centerStart,
//                                               child: Container(
//                                                 height: 2,
//                                                 width: 42,
//                                                 color: const Color(0xff00AA13),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               information['tgl_upload'] != null
//                                                   ? DateFormat('dd MMM yyyy')
//                                                       .format(
//                                                       (information['tgl_upload']
//                                                               as Timestamp)
//                                                           .toDate(),
//                                                     )
//                                                   : 'Tanggal tidak tersedia',
//                                               style: GoogleFonts.montserrat(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 14),
//                   Align(
//                     alignment: AlignmentDirectional.centerStart,
//                     child: AnimatedSmoothIndicator(
//                       activeIndex: activeIndex,
//                       count: maxCount,
//                       effect: ExpandingDotsEffect(
//                         dotWidth: 5,
//                         dotHeight: 5,
//                         activeDotColor: const Color(0xFF00AA13),
//                         dotColor: Colors.grey,
//                         spacing: 5,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text("Error: ${snapshot.error}"),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _homeDesa() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Informasi Desa Kedungmulyo',
//           style: GoogleFonts.montserrat(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 12),
//         StreamBuilder<QuerySnapshot>(
//           stream: DbInformationDesa.getData(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Column(
//                 children: List.generate(
//                   snapshot.data!.docs.length > 2
//                       ? 2
//                       : snapshot.data!.docs.length,
//                   (index) {
//                     DocumentSnapshot informationDesa =
//                         snapshot.data!.docs[index];
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 12),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => InformasiTetapScreen(
//                                 informationDesa: informationDesa.data()
//                                     as Map<String, dynamic>,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.3),
//                                 blurRadius: 3,
//                                 spreadRadius: 0,
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(15),
//                                   topRight: Radius.circular(15),
//                                 ),
//                                 child: Image.network(
//                                   informationDesa['image'] ?? '',
//                                   width: double.infinity,
//                                   height: 140,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return const Icon(Icons.error);
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 18, vertical: 18),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       informationDesa['judul'] ?? '',
//                                       style: GoogleFonts.montserrat(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 1,
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Text(
//                                       informationDesa['isi'] ?? '',
//                                       style: GoogleFonts.montserrat(
//                                         fontSize: 12,
//                                         height: 1.2,
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.black,
//                                       ),
//                                       textAlign: TextAlign.justify,
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 3,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text("Error: ${snapshot.error}"),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
