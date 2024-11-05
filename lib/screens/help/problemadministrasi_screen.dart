import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProblemAdministrasiScreen extends StatefulWidget {
  const ProblemAdministrasiScreen({super.key});

  @override
  _ProblemAdministrasiScreenState createState() => _ProblemAdministrasiScreenState();
}

class _ProblemAdministrasiScreenState extends State<ProblemAdministrasiScreen> {
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
          'Masalah fitur administrasi',
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
                  'Fitur administrasi dalam aplikasi essentials sering kali menjadi titik fokus bagi pengguna yang membutuhkan akses cepat dan efisien untuk melakukan berbagai pengelolaan administratif. Namun, pengguna terkadang mengalami kesulitan dalam menggunakan fitur ini, seperti masalah dalam menginput data, atau kesalahan saat melakukan pengajuan administrasi. Masalah ini dapat disebabkan oleh kurangnya pemahaman tentang cara kerja fitur atau kesalahan teknis yang muncul saat aplikasi digunakan. Ketidaknyamanan ini bisa menghambat pengguna dalam menyelesaikan tugas administratif mereka secara tepat waktu.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'Untuk mengatasi masalah tersebut, pengguna disarankan untuk mengakses panduan penggunaan fitur administrasi yang biasanya tersedia dalam aplikasi. Panduan ini memberikan langkah-langkah yang jelas dan terperinci tentang cara melakukan berbagai tindakan, seperti menginput data dan mengajukan permohonan. Jika masalah tetap terjadi meskipun telah mengikuti panduan, pengguna sebaiknya memeriksa koneksi internet mereka, karena koneksi yang tidak stabil dapat menyebabkan kesalahan saat mengakses fitur administrasi. Pastikan juga untuk menggunakan versi terbaru dari aplikasi, karena pembaruan sering kali mencakup perbaikan bug dan peningkatan performa.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'Jika masalah yang dihadapi berkaitan dengan data yang tidak dapat disimpan atau pengajuan yang tidak berhasil, pengguna dianjurkan untuk menghubungi tim dukungan teknis aplikasi. Melalui saluran dukungan yang disediakan, pengguna dapat menjelaskan masalah yang mereka hadapi dan mendapatkan bantuan secara langsung. Tim dukungan biasanya memiliki akses untuk memeriksa dan memperbaiki masalah teknis yang mungkin tidak dapat diatasi oleh pengguna secara mandiri.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'Sebagai langkah pencegahan, penting bagi pengguna untuk selalu memastikan bahwa mereka telah memeriksa dan mengonfirmasi data yang mereka masukkan sebelum mengajukan permohonan. Mengimplementasikan kebiasaan ini dapat mengurangi kemungkinan kesalahan dan mempercepat proses pengajuan. Dengan memahami cara menggunakan fitur administrasi dengan lebih baik dan memanfaatkan sumber daya yang ada, pengguna dapat meningkatkan efisiensi dalam menyelesaikan tugas-tugas administratif dalam aplikasi essentials.',
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
