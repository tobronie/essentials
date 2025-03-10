// import 'package:essentials/models/user_model.dart';
// import 'package:essentials/screens/help/listproblem_screen.dart';
// import 'package:essentials/services/register_services.dart';
// import 'package:essentials/services/user_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final RegisterService _registerService = RegisterService();
//   final TextEditingController _namaController = TextEditingController();
//   final TextEditingController _nikController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscureText = true;


//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF9F9F9),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 6),
//             child: IconButton(
//               icon: const Icon(
//                 PhosphorIconsRegular.question,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ListProblemScreen()),
//                 );
//               },
//             ),
//           ),
//         ],
//         elevation: 0,
//         backgroundColor: Color(0xffF9F9F9),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 20),
//                 Text(
//                   'Daftarkan diri anda!',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Daftar akun Anda hanya dalam beberapa langkah sederhana dan cepat.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 48),
//                 Form(
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: _namaController,
//                         decoration: InputDecoration(
//                           label: RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'Nama sesuai KTP ',
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 18,
//                                     letterSpacing: 0.1,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '*',
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         style: GoogleFonts.montserrat(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 18),
//                       TextFormField(
//                         controller: _nikController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           label: RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'NIK KTP ',
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 18,
//                                     letterSpacing: 0.1,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '*',
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         style: GoogleFonts.montserrat(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 18),
//                       TextFormField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           label: RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'Email ',
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 18,
//                                     letterSpacing: 0.1,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '*',
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         style: GoogleFonts.montserrat(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 18),
//                       TextFormField(
//                         controller: _passwordController,
//                         obscureText: _obscureText,
//                         decoration: InputDecoration(
//                           label: RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'Password ',
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 18,
//                                     letterSpacing: 0.1,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '*',
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscureText
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Colors.black,
//                             ),
//                             onPressed: _togglePasswordVisibility,
//                           ),
//                         ),
//                         style: GoogleFonts.montserrat(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 52),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF00AA13),
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                           onPressed: () {
//                             if (_namaController.text.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Nama tidak boleh kosong',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       height: 1.2,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                               return;
//                             } else if (_nikController.text.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'NIK tidak boleh kosong',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       height: 1.2,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                               return;
//                             } else if (_emailController.text.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Email tidak boleh kosong',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       height: 1.2,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                               return;
//                             } else if (_passwordController.text.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Password tidak boleh kosong',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       height: 1.2,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                               return;
//                             } else if (_passwordController.text.length < 8) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Password harus terdiri minimal 8 karakter',
//                                     style: GoogleFonts.montserrat(
//                                       fontSize: 12,
//                                       height: 1.2,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                               return;
//                             }
//                             showModalBottomSheet(
//                               context: context,
//                               useRootNavigator: true,
//                               builder: (context) {
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(25),
//                                       topRight: Radius.circular(25),
//                                     ),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 24, vertical: 24),
//                                   height: 396,
//                                   width: double.infinity,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/verification_register.png',
//                                         width: double.infinity,
//                                         fit: BoxFit.fitWidth,
//                                       ),
//                                       const SizedBox(height: 18),
//                                       Text(
//                                         'Pastikan Anda memasukkan data dengan benar',
//                                         style: GoogleFonts.dmSans(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w700,
//                                           height: 1.2,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       const SizedBox(height: 12),
//                                       Column(
//                                         children: [
//                                           Text(
//                                             'Untuk kelancaran proses pendaftaran akun',
//                                             textAlign: TextAlign.left,
//                                             style: GoogleFonts.montserrat(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.2,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 16),
//                                       SizedBox(
//                                         width: double.infinity,
//                                         child: ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 const Color(0xFF00AA13),
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 12),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(50),
//                                             ),
//                                           ),
//                                           onPressed: () {
//                                             final userbaru = UserModel(
//                                               name: _namaController.text,
//                                               nik: _nikController.text,
//                                               kk: "",
//                                               pekerjaan: "",
//                                               dusun: "",
//                                               rt: "",
//                                               rw: "",
//                                               no_hp: "",
//                                               email: _emailController.text,
//                                               password:
//                                                   _passwordController.text,
//                                             );
//                                             DbUser.addData(itemuser: userbaru);
//                                             _registerService.register(
//                                               _emailController.text,
//                                               _passwordController.text,
//                                               context,
//                                             );
//                                             _namaController.clear();
//                                             _nikController.clear();
//                                             _emailController.clear();
//                                             _passwordController.clear();
//                                           },
//                                           child: Text(
//                                             'Saya setuju',
//                                             style: GoogleFonts.montserrat(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w700,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Text(
//                             'Lanjut',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 18),
//         child: Container(
//           child: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'from ',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                 ),
//                 TextSpan(
//                   text: 'NIE',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
