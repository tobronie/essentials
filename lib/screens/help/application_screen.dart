import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationEssentialsScreen extends StatefulWidget {
  const ApplicationEssentialsScreen({super.key});

  @override
  _ApplicationEssentialsScreenState createState() =>
      _ApplicationEssentialsScreenState();
}

class _ApplicationEssentialsScreenState
    extends State<ApplicationEssentialsScreen> {
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
          'Tentang aplikasi essentials',
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
                  'Aplikasi Essentials dirancang untuk memberikan kemudahan dan aksesibilitas bagi pengguna dalam menjalankan berbagai layanan administrasi dan informasi. Dengan antarmuka yang intuitif, aplikasi ini memungkinkan pengguna untuk mengakses informasi yang relevan tentang layanan pemerintah, prosedur administratif, dan berbagai fitur lainnya dengan cepat dan efisien. Aplikasi ini bertujuan untuk menjadi solusi terintegrasi bagi masyarakat, mengurangi kesenjangan informasi, dan meningkatkan transparansi dalam pelayanan publik.',
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
                  'Salah satu fitur utama dari aplikasi Essentials adalah kemampuannya untuk mengakomodasi kebutuhan administrasi masyarakat. Pengguna dapat dengan mudah mengajukan permohonan untuk berbagai layanan, seperti izin usaha, pengajuan bantuan sosial, dan pengelolaan dokumen administratif lainnya. Dengan menggunakan aplikasi ini, pengguna tidak perlu lagi mengunjungi kantor pelayanan secara langsung, sehingga menghemat waktu dan usaha. Selain itu, aplikasi ini juga dilengkapi dengan sistem notifikasi untuk mengingatkan pengguna tentang tenggat waktu dan status permohonan mereka, sehingga meningkatkan efisiensi proses administrasi.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Container(
                  width: 350,
                  height: 160,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/images/app.png',
                      width: 350,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Aplikasi Essentials tidak hanya berfungsi sebagai alat untuk mengakses layanan, tetapi juga sebagai platform untuk berbagi informasi dan edukasi. Melalui fitur informasi, pengguna dapat memperoleh pengetahuan mengenai kebijakan pemerintah, prosedur yang harus diikuti, dan berbagai program yang tersedia. Aplikasi ini berkomitmen untuk terus berkembang dan beradaptasi dengan kebutuhan pengguna, serta meningkatkan kualitas layanan melalui pembaruan fitur dan umpan balik dari pengguna. Dengan demikian, aplikasi Essentials diharapkan dapat memberikan dampak positif dalam meningkatkan kualitas hidup masyarakat dan mendorong partisipasi aktif dalam administrasi publik.s',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
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
