import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProblemPelaporanScreen extends StatefulWidget {
  const ProblemPelaporanScreen({super.key});

  @override
  _ProblemPelaporanScreenState createState() => _ProblemPelaporanScreenState();
}

class _ProblemPelaporanScreenState extends State<ProblemPelaporanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Masalah fitur pelaporan',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F9F9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Fitur pelaporan dalam aplikasi essentials dirancang untuk memudahkan pengguna dalam menyampaikan informasi atau keluhan terkait layanan. Namun, beberapa pengguna sering mengalami kesulitan saat mencoba mengakses atau mengisi formulir pelaporan. Masalah ini dapat disebabkan oleh antarmuka pengguna yang tidak intuitif atau kompleksitas dalam mengisi data yang dibutuhkan. Ketidakjelasan dalam instruksi yang diberikan juga dapat menyebabkan pengguna merasa bingung, yang pada gilirannya dapat menghambat mereka untuk menyampaikan laporan dengan efektif.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'Untuk mengatasi masalah ini, penting bagi pengembang aplikasi untuk menyederhanakan antarmuka fitur pelaporan. Memastikan bahwa tampilan formulir pelaporan lebih ramah pengguna dan menyediakan petunjuk yang jelas serta mudah diikuti akan sangat membantu. Pengguna juga disarankan untuk mengikuti tutorial atau video panduan yang dapat diakses di dalam aplikasi. Dengan memahami langkah-langkah yang diperlukan untuk mengisi laporan dengan benar, pengguna akan lebih percaya diri dalam menggunakan fitur ini.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'Selain itu, jika pengguna mengalami kesulitan teknis, seperti aplikasi yang tidak merespons saat mengirim laporan, mereka disarankan untuk memeriksa koneksi internet mereka dan memastikan aplikasi diperbarui ke versi terbaru. Jika masalah berlanjut, pengguna dapat menghubungi tim dukungan teknis melalui saluran yang disediakan dalam aplikasi. Tim dukungan akan dapat memberikan bantuan dan solusi untuk masalah teknis yang mungkin dihadapi pengguna.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'Sebagai langkah pencegahan, penting untuk mendorong pengguna agar meluangkan waktu untuk memeriksa dan memastikan bahwa semua informasi yang dimasukkan dalam laporan adalah akurat sebelum mengirimkannya. Hal ini tidak hanya akan membantu mengurangi kemungkinan kesalahan tetapi juga mempercepat proses penanganan laporan. Dengan pendekatan yang lebih sistematis dan dukungan yang tepat, pengguna akan lebih mudah dalam menggunakan fitur pelaporan, yang pada akhirnya meningkatkan kepuasan mereka terhadap aplikasi essentials.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
