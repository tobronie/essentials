// import 'package:essentials/screens/help/privacy_screen.dart';
// import 'package:essentials/screens/help/service_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:flutter/gestures.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int activeIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF9F9F9),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Image.asset(
//                       'assets/images/logo_warna.png',
//                       width: 24,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Essentials',
//                       textAlign: TextAlign.right,
//                       style: GoogleFonts.montserrat(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 82),
//                 // Carousel
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     autoPlay: true,
//                     autoPlayInterval: Duration(seconds: 3),
//                     enlargeCenterPage: false,
//                     enableInfiniteScroll: true,
//                     viewportFraction: 1,
//                     height: MediaQuery.of(context).size.height * 0.42,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         activeIndex = index;
//                       });
//                     },
//                   ),
//                   items: [
//                     // Item 1
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 6),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/images/onboarding_1.png',
//                             width: double.infinity,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           const SizedBox(height: 24),
//                           Text(
//                             'Selamat datang wargaku!',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Aplikasi yang buat hidup lebih nyaman. Siap bantu kebutuhan anda.',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               height: 1.2,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Item 2
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 6),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/images/onboarding_2.png',
//                             width: double.infinity,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           const SizedBox(height: 24),
//                           Text(
//                             'Administrasi desa',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Aplikasi dengan segala pelayanan administrasi desa Kedungmulyo. Tanpa menyita waktu anda.',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               height: 1.2,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Item 3
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 6),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/images/onboarding_3.png',
//                             width: double.infinity,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           const SizedBox(height: 24),
//                           Text(
//                             'Pengaduan desa',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Aplikasi yang siap menjadi tempat pengaduan dari segala permasalahan desa Kedungmulyo.',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               height: 1.2,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Item 4
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 6),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/images/onboarding_4.png',
//                             width: double.infinity,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           const SizedBox(height: 24),
//                           Text(
//                             'Informasi desa',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Aplikasi dengan sejuta informasi Desa Kedungmulyo, dengan berita terkini dan isu-isu yang penting',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               height: 1.2,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 14),
//                 // Indikator Carousel
//                 Center(
//                   child: AnimatedSmoothIndicator(
//                     activeIndex: activeIndex,
//                     count: 4,
//                     effect: ExpandingDotsEffect(
//                       dotWidth: 5,
//                       dotHeight: 5,
//                       activeDotColor: const Color(0xFF00AA13),
//                       dotColor: Colors.grey,
//                       spacing: 5,
//                     ),
//                   ),
//                 ),
//                 // Tombol Masuk
//                 const SizedBox(height: 52),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF00AA13),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/login');
//                   },
//                   child: Text(
//                     'Masuk',
//                     style: GoogleFonts.montserrat(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 // Tombol Daftar dulu
//                 const SizedBox(height: 12),
//                 OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     side: BorderSide(color: const Color(0xFF00AA13), width: 2),
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/register');
//                   },
//                   child: Text(
//                     'Belum punya akun? Daftar dulu',
//                     style: GoogleFonts.montserrat(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xFF00AA13),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 18, left: 18, right: 18),
//         child: Container(
//           child: RichText(
//             textAlign: TextAlign.left,
//             text: TextSpan(
//               style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 height: 1.2,
//                 color: Colors.black,
//               ),
//               children: [
//                 TextSpan(
//                   text: 'Dengan masuk atau mendaftar, kamu menyetujui ',
//                 ),
//                 TextSpan(
//                   text: 'Ketentuan Layanan',
//                   style: TextStyle(
//                     color: const Color(0xFF5E28FF),
//                     decoration: TextDecoration.underline,
//                     decorationColor: Color(0xFF5E28FF),
//                   ),
//                   recognizer: TapGestureRecognizer()
//                     ..onTap = () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ServiceScreen()),
//                       );
//                     },
//                 ),
//                 TextSpan(
//                   text: ' & ',
//                 ),
//                 TextSpan(
//                   text: 'Kebijakan Privasi',
//                   style: TextStyle(
//                     color: const Color(0xFF5E28FF),
//                     decoration: TextDecoration.underline,
//                     decorationColor: Color(0xFF5E28FF),
//                   ),
//                   recognizer: TapGestureRecognizer()
//                     ..onTap = () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => PrivacyScreen()),
//                       );
//                     },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
