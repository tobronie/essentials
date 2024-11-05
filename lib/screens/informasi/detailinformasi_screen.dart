import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InformasiDetailScreen extends StatefulWidget {
  const InformasiDetailScreen({super.key});

  @override
  _InformasiDetailScreenState createState() => _InformasiDetailScreenState();
}

class _InformasiDetailScreenState extends State<InformasiDetailScreen> {
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: IconButton(
              icon: const Icon(
                PhosphorIconsRegular.arrowBendUpRight,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              icon: const Icon(
                PhosphorIconsRegular.bookmarkSimple,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xffF9F9F9),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/test_1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 8, bottom: 24),
                margin: const EdgeInsets.only(top: 216),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 3,
                      width: 40,
                      color: Color(0xff00AA13),
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Kerusakan Got di Jl. Kalikening barat samping warung',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        height: 2,
                        width: 118,
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            'Infrastruktur',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            'Senin, 01-Juli-2024',
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Hujan deras yang mengguyur wilayah Jl. Kalikening Barat menyebabkan kerusakan pada sistem drainase (got) di area tersebut. Insiden ini terjadi tepat pada Senin sore, setelah waktu Ashar. Akibat derasnya air hujan yang tak tertampung oleh saluran got, terjadi genangan yang memicu luapan air ke permukaan jalan, hingga mengakibatkan kerusakan pada bagian dinding got.',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Selain intensitas hujan yang tinggi, kerusakan diduga dipicu oleh sumbatan sampah yang menumpuk di beberapa titik saluran air, membuat air tidak mengalir dengan lancar. Warga setempat melaporkan adanya bau tak sedap dan aliran air yang terhambat sebelum hujan turun, namun keadaan memburuk setelah hujan mengguyur selama beberapa jam.',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Salah seorang warga, Pak Rahman, yang tinggal di sekitar lokasi kejadian, menyebutkan, "Setiap kali hujan deras, got di sini sering meluap. Sampah yang dibuang sembarangan jadi penyebab utama. Kalau terus dibiarkan, kami khawatir ini akan jadi masalah yang lebih besar."',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Pihak pemerintah daerah sudah diberitahukan terkait kerusakan ini, dan diharapkan segera ada tindakan untuk memperbaiki got yang rusak serta membersihkan saluran agar tidak terjadi masalah serupa di kemudian hari."',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
