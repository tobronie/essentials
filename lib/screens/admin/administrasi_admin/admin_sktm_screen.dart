import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:essentials/services/download/download_ad_sktm.dart';
import 'package:essentials/services/update/update_ad_sktm.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';

class Admin_SKTMScreen extends StatefulWidget {
  final String id;
  const Admin_SKTMScreen({super.key, required this.id});

  @override
  _Admin_SKTMScreenState createState() => _Admin_SKTMScreenState();
}

class _Admin_SKTMScreenState extends State<Admin_SKTMScreen> {
  final UploadSKTMService _UploadSKTMService = UploadSKTMService();
  File? selectedDocument;
  bool _isImageVisibleKTP = false;
  bool _isImageVisibleKK = false;
  late Future<Map<String, dynamic>?> _futureSKTM;

  Future<void> pickDocument() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedDocument = File(result.files.single.path!);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file selected or an error occurred'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _futureSKTM = getSKTM();
  }

  Future<Map<String, dynamic>?> getSKTM() async {
    String url =
        'https://essentials.my.id/get_ad_sktm.php?id_sktm=${widget.id}';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          return data[0];
        } else if (data is Map<String, dynamic>) {
          return data;
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<void> uploadSK() async {
    print("Mengirim ID: ${widget.id}");
    if (selectedDocument == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih file terlebih dahulu sebelum mengupload!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await _UploadSKTMService.sktm(
      widget.id,
      selectedDocument!,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
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
          'Verifikasi SKTM',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F9F9),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _futureSKTM,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Data tidak ditemukan"));
          }

          var sktm = snapshot.data!;
          String namaPemohon = sktm["nama"] ?? "Tidak diketahui";
          String noHpPemohon = sktm["no_hp"] ?? "Tidak diketahui";
          String emailPemohon = sktm["email"] ?? "Tidak diketahui";
          String tglUploadPemohon = sktm["sktm_tgl_upload"] != null
              ? DateFormat('dd MMMM yyyy - HH:mm:ss').format(
                  DateTime.parse(sktm["sktm_tgl_upload"]),
                )
              : "Tidak diketahui";
          String fotoKTP = sktm["sktm_foto_ktp"] ?? "Tidak diketahui";
          String fotoKK = sktm["sktm_foto_kk"] ?? "Tidak diketahui";
          String namaWali = sktm["sktm_nama_wali"] ?? "Tidak diketahui";
          String nominalPendapatan = sktm["sktm_nominal"] ?? "Tidak diketahui";
          String rincianBiaya = (sktm["sktm_rincian"] ?? "").isEmpty
              ? "Rincian tidak ditulis"
              : sktm["sktm_rincian"];
          String JudulPengaduan = sktm["sktm_judul"] ?? "Tidak diketahui";
          String suratKonfirmasiData =
              sktm["sktm_surat_konfirmasi"] ?? "Tidak diketahui";
          String konfirmasiData = sktm["sktm_konfirmasi"] ?? "Tidak diketahui";

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
                    const SizedBox(height: 8),
                    _imageKTP(fotoKTP),
                    const SizedBox(height: 12),
                    _imageKK(fotoKK),
                    const SizedBox(height: 12),
                    _namaWali(namaWali),
                    const SizedBox(height: 12),
                    _nominalPendapatan(nominalPendapatan),
                    const SizedBox(height: 12),
                    _rincianBiaya(rincianBiaya),
                    const SizedBox(height: 24),
                    const Divider(
                      color: Color(0xffD9D9D9),
                    ),
                    const SizedBox(height: 24),
                    _dataPemohon(),
                    const SizedBox(height: 6),
                    _namaPemohon(namaPemohon),
                    const SizedBox(height: 12),
                    _noHpPemohon(noHpPemohon),
                    const SizedBox(height: 12),
                    _emailPemohon(emailPemohon),
                    const SizedBox(height: 12),
                    _tglUploadPemohon(tglUploadPemohon),
                    const SizedBox(height: 24),
                    const Divider(
                      color: Color(0xffD9D9D9),
                    ),
                    const SizedBox(height: 24),
                    _verifikasiKepalaDesa(konfirmasiData),
                    const SizedBox(height: 24),
                    if (suratKonfirmasiData.isNotEmpty)
                      _document(namaPemohon, JudulPengaduan,
                          suratKonfirmasiData, context)
                    else if (konfirmasiData == "sudah")
                      _konfirmasi(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
              'Data Pengajuan:',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _imageKTP(String KTP) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto KTP Pemohon',
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
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 2, left: 8, top: 8, bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.file(),
                            color: Colors.black.withOpacity(0.7),
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Foto KTP Tersedia",
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
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isImageVisibleKTP
                          ? PhosphorIcons.eye()
                          : PhosphorIcons.eyeSlash(),
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isImageVisibleKTP = !_isImageVisibleKTP;
                      });
                      _showDialogFotoKTP(context, KTP);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _imageKK(String KK) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto Kartu Keluarga',
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
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 2, left: 8, top: 8, bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.file(),
                            color: Colors.black.withOpacity(0.7),
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Foto Kartu Keluarga Tersedia",
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
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isImageVisibleKK
                          ? PhosphorIcons.eye()
                          : PhosphorIcons.eyeSlash(),
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isImageVisibleKK = !_isImageVisibleKK;
                      });
                      _showDialogFotoKK(context, KK);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _namaWali(String Wali) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Wali Keluarga',
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
                Wali,
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
      ],
    );
  }

  Column _nominalPendapatan(String Nominal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nominal Pendapatan Wali perBulan',
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
                Nominal,
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
      ],
    );
  }

  Column _rincianBiaya(String Rincian) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rincian Biaya Hidup',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
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
                Rincian,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Rincian == "Rincian tidak ditulis"
                      ? Colors.red
                      : Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _dataPemohon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Akun:',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _namaPemohon(String nama) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                nama,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _noHpPemohon(String noHp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Handphone',
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
                noHp,
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
      ],
    );
  }

  Column _emailPemohon(String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
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
                email,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _tglUploadPemohon(String tglUpload) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waktu Pengajuan',
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
                tglUpload,
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
      ],
    );
  }

  void _showImageDialog(
      BuildContext context, String foto, VoidCallback onClose) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          backgroundColor: Colors.transparent,
          child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 5.0,
            child: Image(
              image: _getImageProvider(foto),
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    ).then((_) {
      setState(onClose);
    });
  }

  void _showDialogFotoKTP(BuildContext context, String foto) {
    if (_isImageVisibleKTP) {
      _showImageDialog(context, foto, () => _isImageVisibleKTP = false);
    }
  }

  void _showDialogFotoKK(BuildContext context, String foto) {
    if (_isImageVisibleKK) {
      _showImageDialog(context, foto, () => _isImageVisibleKK = false);
    }
  }

  ImageProvider _getImageProvider(String fotoInfo) {
    if (fotoInfo.isEmpty) {
      return AssetImage('assets/images/no_image.jpg');
    }
    String baseUrl = "https://essentials.my.id/uploads/";

    if (fotoInfo.startsWith('http')) {
      return NetworkImage(fotoInfo);
    }

    return NetworkImage("$baseUrl$fotoInfo");
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

  Container _konfirmasi() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFD9D9D9),
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (selectedDocument != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.description,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        selectedDocument!.path.split('/').last,
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (selectedDocument == null)
                              TextButton(
                                onPressed: () async {
                                  await pickDocument();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      PhosphorIconsRegular.fileArrowUp,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Unggah Dokumen di sini',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (selectedDocument != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: const Icon(
                            PhosphorIconsRegular.trash,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedDocument = null;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedDocument == null
                    ? Colors.grey
                    : const Color(0xFF0D0140),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: selectedDocument == null
                  ? null
                  : () async {
                      await uploadSK();
                    },
              child: Text(
                'Konfirmasi',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: selectedDocument == null ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _document(
      String filePDF, String Nama, String Judul, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("Dokumen diklik, mulai mengunduh...");
        print("ID SKTM yang dikirim: ${widget.id}");
        if (widget.id.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("ID SKTM tidak valid"),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        DownloadServicesSKTM downloadServicesSKTM = DownloadServicesSKTM();
        String? filePath = await downloadServicesSKTM.downloadAdministrasiSKTM(
            context, widget.id);

        if (filePath != null) {
          print("File berhasil diunduh: $filePath");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("File berhasil diunduh!"),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          print("Gagal mengunduh file.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Gagal mengunduh file."),
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
                      const SizedBox(height: 8),
                      Text(
                        "file sudah diunggah",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.1,
                          fontWeight: FontWeight.w400,
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
    );
  }
}
