import 'package:essentials/services/download/download_ad_akte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

class ActivityAdministrasiScreen extends StatefulWidget {
  final String id;
  final String idType;

  const ActivityAdministrasiScreen(
      {super.key, required this.id, required this.idType});

  @override
  _ActivityAdministrasiScreenState createState() =>
      _ActivityAdministrasiScreenState();
}

class _ActivityAdministrasiScreenState
    extends State<ActivityAdministrasiScreen> {
  late Future<Map<String, dynamic>?> _futureData;

  Future<Map<String, dynamic>?> getData() async {
    String endpoint = getEndpoint(widget.idType);
    String url =
        'http://10.0.2.2:8080/essentials_api/$endpoint?${widget.idType}=${widget.id}';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
        return responseData.isNotEmpty ? responseData.first : null;
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _futureData = getData();
  }

  String getEndpoint(String idType) {
    Map<String, String> endpointMap = {
      'id_akte': 'get_ad_akte.php',
      'id_domisili': 'get_ad_domisili.php',
      'id_kematian': 'get_ad_kematian.php',
      'id_kk': 'get_ad_kk.php',
      'id_ktp': 'get_ad_ktp.php',
      'id_nikah': 'get_ad_nikah.php',
      'id_pendudukan': 'get_ad_pendudukan.php',
      'id_penghasilan': 'get_ad_penghasilan_ortu.php',
      'id_sktm': 'get_ad_sktm.php',
      'id_tanah': 'get_ad_tanah.php',
      'id_usaha': 'get_ad_usaha.php',
    };

    return endpointMap[idType] ?? '';
  }

  String formatTanggal(Map<String, dynamic> data) {
    String? rawDate = data['ak_tgl_upload'] ??
        data['dom_tgl_upload'] ??
        data['kem_tgl_upload'] ??
        data['kk_tgl_upload'] ??
        data['kt_tgl_upload'] ??
        data['ni_tgl_upload'] ??
        data['pen_tgl_upload'] ??
        data['has_tgl_upload'] ??
        data['sktm_tgl_upload'] ??
        data['tan_tgl_upload'] ??
        data['us_tgl_upload'];

    if (rawDate != null) {
      try {
        return DateFormat('dd MMMM yyyy - HH:mm:ss')
            .format(DateTime.parse(rawDate));
      } catch (e) {
        return 'Format tanggal tidak valid';
      }
    }
    return 'Tanggal tidak tersedia';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Data tidak ditemukan"));
          }

          var data = snapshot.data!;

          String NamaPengaduan = data['nama'] ?? "Tidak diketahui";
          String JudulPengaduan = data['ak_judul'] ??
              data['dom_judul'] ??
              data['kem_judul'] ??
              data['kk_judul'] ??
              data['kt_judul'] ??
              data['ni_judul'] ??
              data['pen_judul'] ??
              data['has_judul'] ??
              data['sktm_judul'] ??
              data['tan_judul'] ??
              data['us_judul'] ??
              "Tidak diketahui";
          String? tglUploadRaw = data['ak_tgl_upload'] ??
              data['dom_tgl_upload'] ??
              data['kem_tgl_upload'] ??
              data['kk_tgl_upload'] ??
              data['kt_tgl_upload'] ??
              data['ni_tgl_upload'] ??
              data['pen_tgl_upload'] ??
              data['has_tgl_upload'] ??
              data['sktm_tgl_upload'] ??
              data['tan_tgl_upload'] ??
              data['us_tgl_upload'];
          String TglUpload = tglUploadRaw != null
              ? DateFormat('dd MMMM yyyy - HH:mm')
                  .format(DateTime.parse(tglUploadRaw))
              : "Tidak diketahui";

          String Verifikasi = data['ak_konfirmasi'] ??
              data['dom_konfirmasi'] ??
              data['kem_konfirmasi'] ??
              data['kk_konfirmasi'] ??
              data['kt_konfirmasi'] ??
              data['ni_konfirmasi'] ??
              data['pen_konfirmasi'] ??
              data['has_konfirmasi'] ??
              data['sktm_konfirmasi'] ??
              data['tan_konfirmasi'] ??
              data['us_konfirmasi'] ??
              "Tidak diketahui";

          String SuratKonfirmasi = data['ak_surat_konfirmasi'] ??
              data['dom_surat_konfirmasi'] ??
              data['kem_surat_konfirmasi'] ??
              data['kk_surat_konfirmasi'] ??
              data['kt_surat_konfirmasi'] ??
              data['ni_surat_konfirmasi'] ??
              data['pen_surat_konfirmasi'] ??
              data['has_surat_konfirmasi'] ??
              data['sktm_surat_konfirmasi'] ??
              data['tan_surat_konfirmasi'] ??
              data['us_surat_konfirmasi'] ??
              "Tidak diketahui";
          return SafeArea(
            child: Container(
              color: const Color(0xffF9F9F9),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _dataPengajuan(),
                    const SizedBox(height: 18),
                    _nama(NamaPengaduan),
                    const SizedBox(height: 12),
                    _judul(JudulPengaduan),
                    const SizedBox(height: 12),
                    _tglUpload(TglUpload),
                    const SizedBox(height: 12),
                    _verifikasiKepalaDesa(Verifikasi),
                    const SizedBox(height: 24),
                    if (SuratKonfirmasi.isNotEmpty)
                      _document(SuratKonfirmasi, NamaPengaduan, JudulPengaduan,
                          context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column _nama(String NamaData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Pengaduan',
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
                NamaData,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _judul(String JudulData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Pengaduan',
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
                JudulData,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _tglUpload(String tglUploadData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waktu Upload Pengajuan',
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
                tglUploadData,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _dataPengajuan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Pengaduan Anda:',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _verifikasiKepalaDesa(String verifikasi) {
    String statusText = "";
    Color statusColor = Colors.black;

    switch (verifikasi) {
      case "menunggu":
        statusText = "Menunggu disetujui";
        statusColor = const Color(0xffFF9D00);
        break;
      case "sudah":
        statusText = "Telah disetujui";
        statusColor = const Color(0xff00AA13);
        break;
      case "tidak":
        statusText = "Tidak disetujui";
        statusColor = const Color(0xffFF0004);
        break;
      default:
        statusText = "Status tidak diketahui";
        statusColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "$statusText ",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                height: 1.1,
                fontWeight: FontWeight.w500,
                color: statusColor,
              ),
            ),
            TextSpan(
              text: "oleh Kepala Desa Kedungmulyo Bpk. Badrun",
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

  Widget _document(
      String filePDF, String Nama, String Judul, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("Dokumen diklik!");

        DownloadServices downloadServices = DownloadServices();
        String? filePath =
            await downloadServices.downloadAdministrasiAkte(context, filePDF);

        if (filePath != null) {
          OpenFile.open(filePath);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Gagal mengunduh atau membuka file"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
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
                offset: const Offset(0.0, 0.0),
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
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: Nama),
                            TextSpan(text: ' - '),
                            TextSpan(text: Judul),
                          ],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
