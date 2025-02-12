import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivityAdministrasiScreen extends StatefulWidget {
  final String id;
  const ActivityAdministrasiScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ActivityAdministrasiScreenState createState() =>
      _ActivityAdministrasiScreenState();
}

class _ActivityAdministrasiScreenState
    extends State<ActivityAdministrasiScreen> {
  Map<String, dynamic>? data;
  bool isLoading = true;

  Future<List<dynamic>> fetchData(String endpoint) async {
    String url = 'http://10.0.2.2:8080/essentials_api/$endpoint?(id_akte atau id_domisili atau id_kematian dst)=${widget.id}';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Gagal mengambil data dari $endpoint');
      }
    } catch (e) {
      print("Error fetching $endpoint: $e");
      return [];
    }
  }

  Future<List<List<dynamic>>> getAllData() async {
    return await Future.wait([
      fetchData('get_ad_akte.php'),
      fetchData('get_ad_domisili.php'),
      fetchData('get_ad_kematian.php'),
      fetchData('get_ad_kk.php'),
      fetchData('get_ad_ktp.php'),
      fetchData('get_ad_nikah.php'),
      fetchData('get_ad_pendudukan.php'),
      fetchData('get_ad_penghasilan_ortu.php'),
      fetchData('get_ad_sktm.php'),
      fetchData('get_ad_tanah.php'),
      fetchData('get_ad_usaha.php'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Administrasi Anda',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xffF9F9F9),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : data == null
                ? const Center(child: Text('Data tidak ditemukan'))
                : Container(
                    color: const Color(0xffF9F9F9),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _data(),
                          const SizedBox(height: 52),
                          _verifikasiKepalaDesa(),
                          const SizedBox(height: 16),
                          _document(),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Column _data() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data pengajuan surat Anda:',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            height: 1.2,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Pemohon',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item['nama'] ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Pengajuan',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item['ak_judul'] ??
                    item['dom_judul'] ??
                    item['kem_judul'] ??
                    item['kk_judul'] ??
                    item['kt_judul'] ??
                    item['ni_judul'] ??
                    item['pen_judul'] ??
                    item['has_judul'] ??
                    item['sktm_judul'] ??
                    item['tan_judul'] ??
                    item['us_judul'] ??
                    '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal Pengajuan',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item['ak_tgl_upload'] ??
                    item['dom_tgl_upload'] ??
                    item['kem_tgl_upload'] ??
                    item['kk_tgl_upload'] ??
                    item['kt_tgl_upload'] ??
                    item['ni_tgl_upload'] ??
                    item['pen_tgl_upload'] ??
                    item['has_tgl_upload'] ??
                    item['sktm_tgl_upload'] ??
                    item['tan_tgl_upload'] ??
                    item['us_tgl_upload'] ??
                    '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _verifikasiKepalaDesa() {
    return Container(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Telah disetujui',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                height: 1.1,
                fontWeight: FontWeight.w500,
                color: Color(0xff00AA13),
              ),
            ),
            TextSpan(text: ' '),
            TextSpan(
              text: 'Kepala Desa Bpk. Hj. Ahmad Fulan, S.H, M.Sos',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                height: 1.1,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Column _document() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {},
          child: DottedBorder(
            color: const Color(0xffD9D9D9),
            strokeWidth: 2,
            borderType: BorderType.RRect,
            radius: Radius.circular(10),
            child: Container(
              width: double.infinity,
              height: 108,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/pdf-icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fulan si Fulan - Suat Keterangan Tidak Mampu (SKTM)',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              height: 1.1,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '210 kb',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
