import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Kebijakan Privasi',
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
                  'Aplikasi Essentials sangat menghargai dan menjaga privasi pengguna dengan serius. Setiap data yang dikumpulkan dari pengguna hanya digunakan untuk meningkatkan pengalaman dan fungsionalitas aplikasi. Kami berkomitmen untuk tidak membagikan data pribadi pengguna kepada pihak ketiga tanpa izin eksplisit dari pengguna, kecuali jika diharuskan oleh hukum. Informasi yang dikumpulkan, seperti data lokasi, riwayat penggunaan, dan data lainnya, digunakan untuk menyediakan layanan yang relevan dan meningkatkan kualitas aplikasi.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'Kami juga mengambil langkah-langkah yang diperlukan untuk melindungi informasi pribadi pengguna dari akses yang tidak sah. Data pengguna dienkripsi dan disimpan dengan aman di server kami. Kami terus memperbarui kebijakan privasi dan prosedur keamanan untuk memastikan bahwa data pengguna tetap aman dan terlindungi. Pengguna dapat mengontrol preferensi privasi mereka melalui pengaturan aplikasi, serta memilih untuk membatasi jenis informasi yang dibagikan kepada kami.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'Aplikasi Essentials juga menyediakan transparansi penuh terkait dengan penggunaan data pribadi pengguna. Kami memberi pengguna informasi yang jelas tentang data apa saja yang dikumpulkan, bagaimana data tersebut digunakan, dan dengan siapa data tersebut dapat dibagikan. Pengguna memiliki hak untuk mengakses, memperbarui, atau menghapus data pribadi mereka kapan saja melalui pengaturan akun. Dengan kebijakan ini, kami berupaya memastikan bahwa setiap pengguna merasa nyaman dan aman saat menggunakan aplikasi kami, sambil tetap mematuhi regulasi perlindungan data yang berlaku.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
