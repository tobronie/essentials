import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InformasiTetapScreen extends StatefulWidget {
  const InformasiTetapScreen({super.key});

  @override
  _InformasiTetapScreenState createState() => _InformasiTetapScreenState();
}

class _InformasiTetapScreenState extends State<InformasiTetapScreen> {
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
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              icon: const Icon(
                PhosphorIconsRegular.arrowBendUpRight,
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
                  image: AssetImage('assets/images/informasi_1.jpeg'),
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
                        'Pendaftaran Calon Among Desa Kedungmulyo 2024',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Desa Kedungmulyo kembali membuka kesempatan bagi pemuda-pemudi untuk menjadi Among Desa tahun 2024. Sebagai sosok yang berperan penting dalam menjaga kelancaran berbagai acara adat dan kegiatan desa, Among Desa memiliki tanggung jawab besar dalam melestarikan budaya dan tradisi lokal. Pendaftaran ini terbuka bagi warga asli Desa Kedungmulyo yang berusia minimal 18 tahun dan bersedia mengabdikan diri selama satu tahun.',
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
                        'Proses pendaftaran berlangsung dari 1 hingga 30 November 2024, di mana peserta harus melengkapi berkas berupa fotokopi KTP, surat keterangan sehat, dan surat pernyataan kesediaan menjadi Among Desa. Seleksi administratif akan dilakukan setelah pendaftaran ditutup, diikuti oleh wawancara dengan tokoh masyarakat desa untuk menilai kesesuaian calon dengan peran tersebut.',
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
                        'Calon yang terpilih sebagai Among Desa diharapkan tidak hanya mampu menjaga tradisi, tetapi juga memiliki keterampilan komunikasi yang baik serta inisiatif dalam menghadapi berbagai tantangan di lapangan. Peran ini menuntut sikap yang proaktif dan kemampuan untuk bekerjasama dengan berbagai pihak dalam desa.',
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
                        'Pengumuman calon terpilih akan dilakukan pada 20 Desember 2024. Diharapkan, peserta yang terpilih nantinya dapat melanjutkan tradisi desa serta berkontribusi dalam menjaga harmoni masyarakat Kedungmulyo melalui peran aktif mereka sebagai Among Desa.',
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
