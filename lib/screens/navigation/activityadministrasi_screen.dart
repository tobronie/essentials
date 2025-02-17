import 'package:essentials/services/download_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

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
  Map<String, dynamic>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String endpoint = getEndpoint(widget.idType);
    if (endpoint.isEmpty) {
      setState(() {
        isLoading = false;
        data = null;
      });
      return;
    }

    String url =
        'http://10.0.2.2:8080/essentials_api/$endpoint?${widget.idType}=${widget.id}';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          isLoading = false;
          data = responseData.isNotEmpty ? responseData.first : null;
        });
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
        data = null;
      });
    }
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

  String formatTanggal(Map<String, dynamic> item) {
    String? rawDate = item['ak_tgl_upload'] ??
        item['dom_tgl_upload'] ??
        item['kem_tgl_upload'] ??
        item['kk_tgl_upload'] ??
        item['kt_tgl_upload'] ??
        item['ni_tgl_upload'] ??
        item['pen_tgl_upload'] ??
        item['has_tgl_upload'] ??
        item['sktm_tgl_upload'] ??
        item['tan_tgl_upload'] ??
        item['us_tgl_upload'];

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
                          _data(data!),
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

  Widget _data(Map<String, dynamic> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data pengajuan surat Anda:',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 18),
        _buildInfoBox('Nama Pemohon', item['nama'] ?? '-'),
        const SizedBox(height: 12),
        _buildInfoBox(
            'Jenis Pengajuan',
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
                '-'),
        const SizedBox(height: 12),
        _buildInfoBox('Tanggal Pengajuan', formatTanggal(item))
      ],
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
            value,
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

  Widget _document() {
    String nama = data?['nama'] ?? '';
    String id = data?['id'] ?? '';

    if (id.isEmpty) {
      return SizedBox.shrink();
    }

    String judul = data?['ak_judul'] ??
        data?['dom_judul'] ??
        data?['kem_judul'] ??
        data?['kk_judul'] ??
        data?['kt_judul'] ??
        data?['ni_judul'] ??
        data?['pen_judul'] ??
        data?['has_judul'] ??
        data?['sktm_judul'] ??
        data?['tan_judul'] ??
        data?['us_judul'] ??
        'Judul Tidak Ditemukan';

    List<String?> suratKonfirmasiList = [
      data?['ak_surat_konfirmasi'],
      data?['dom_surat_konfirmasi'],
      data?['kem_surat_konfirmasi'],
      data?['kk_surat_konfirmasi'],
      data?['kt_surat_konfirmasi'],
      data?['ni_surat_konfirmasi'],
      data?['pen_surat_konfirmasi'],
      data?['has_surat_konfirmasi'],
      data?['sktm_surat_konfirmasi'],
      data?['tan_surat_konfirmasi'],
      data?['us_surat_konfirmasi'],
    ];

    String? suratKonfirmasi = suratKonfirmasiList.firstWhere(
      (element) => element != null && element.isNotEmpty,
      orElse: () => null,
    );

    if (suratKonfirmasi == null) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          // onTap: () async {
          //   var downloadService = DownloadServices();
          //   if (id.startsWith("id_akte")) {
          //     await downloadService.download_AdministrasiAkte(context);
          //   } else if (id.startsWith("id_domisili")) {
          //     await downloadService.download_AdministrasiDomisili(context);
          //   } else if (id.startsWith("id_kematian")) {
          //     await downloadService.download_AdministrasiKematian(context);
          //   } else if (id.startsWith("id_kk")) {
          //     await downloadService.download_AdministrasiKK(context);
          //   } else if (id.startsWith("id_ktp")) {
          //     await downloadService.download_AdministrasiKTP(context);
          //   } else if (id.startsWith("id_nikah")) {
          //     await downloadService.download_AdministrasiNikah(context);
          //   } else if (id.startsWith("id_pendudukan")) {
          //     await downloadService.download_AdministrasiPendudukan(context);
          //   } else if (id.startsWith("id_penghasilan")) {
          //     await downloadService.download_AdministrasiPenghasilan(context);
          //   } else if (id.startsWith("id_sktm")) {
          //     await downloadService.download_AdministrasiSKTM(context);
          //   } else if (id.startsWith("id_tanah")) {
          //     await downloadService.download_AdministrasiTanah(context);
          //   } else if (id.startsWith("id_usaha")) {
          //     await downloadService.download_AdministrasiUsaha(context);
          //   }
          // },
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
                                TextSpan(text: nama),
                                TextSpan(text: ' - '),
                                TextSpan(text: judul),
                              ],
                            ),
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
