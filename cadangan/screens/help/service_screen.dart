// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ServiceScreen extends StatefulWidget {
//   const ServiceScreen({super.key});

//   @override
//   _ServiceScreenState createState() => _ServiceScreenState();
// }

// class _ServiceScreenState extends State<ServiceScreen> {
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
//           'Ketentuan Layanan',
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
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Aplikasi Essentials merupakan platform yang dirancang untuk memberikan kemudahan bagi masyarakat Desa Kedungmulyo dalam mengakses berbagai layanan administrasi dan pelaporan. Dengan menggunakan aplikasi ini, pengguna dapat dengan mudah mengajukan laporan terkait permasalahan yang ada di desa, mulai dari isu lingkungan, infrastruktur, hingga permasalahan sosial lainnya. Setiap laporan yang diajukan oleh pengguna akan diterima dan dikelola oleh pihak pemerintah desa untuk ditindaklanjuti secara cepat dan efisien, dengan tujuan menciptakan lingkungan yang lebih baik dan harmonis bagi seluruh warga desa.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Selain fitur pelaporan, aplikasi ini juga menyediakan layanan administrasi masyarakat yang memungkinkan pengguna untuk mengurus berbagai kebutuhan administrasi dengan mudah. Pengguna dapat mengakses layanan seperti pembuatan surat menyurat, permohonan izin, dan layanan administrasi lainnya tanpa harus datang langsung ke kantor desa. Fitur ini bertujuan untuk menghemat waktu dan tenaga, memberikan kenyamanan, dan meningkatkan transparansi dalam proses administrasi.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Aplikasi Essentials juga menyediakan informasi terkait Desa Kedungmulyo yang dapat diakses oleh seluruh masyarakat. Pengguna dapat mengikuti berita terkini, informasi penting, serta kegiatan yang berlangsung di desa. Hal ini bertujuan untuk meningkatkan partisipasi aktif warga dalam berbagai kegiatan desa, memperkuat rasa kebersamaan, serta memastikan bahwa setiap individu tetap terinformasi mengenai perkembangan dan isu yang ada di sekitar mereka. Dengan adanya informasi yang cepat dan mudah diakses, diharapkan setiap warga dapat mengambil keputusan yang lebih baik dan berkontribusi dalam memajukan desa.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Sebagai syarat penggunaan, setiap pengguna aplikasi Essentials wajib menyetujui Ketentuan Layanan yang berlaku. Pengguna diharapkan menggunakan aplikasi ini dengan cara yang etis dan tidak menyalahgunakan fitur-fitur yang ada untuk kepentingan pribadi atau merugikan pihak lain. Semua data yang diberikan oleh pengguna, baik itu data pribadi maupun laporan, akan diperlakukan dengan penuh tanggung jawab dan dijaga kerahasiaannya sesuai dengan kebijakan privasi yang berlaku. Dengan menggunakan aplikasi ini, pengguna diharapkan berkontribusi untuk menciptakan sebuah ekosistem digital yang aman, transparan, dan bermanfaat bagi masyarakat Desa Kedungmulyo.',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     height: 1.2,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
