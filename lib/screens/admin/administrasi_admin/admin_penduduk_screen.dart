import 'dart:convert';
import 'dart:typed_data';
import 'package:essentials/services/update/update_ad_pendudukan.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';

class Admin_PendudukScreen extends StatefulWidget {
  final String id;
  const Admin_PendudukScreen({super.key, required this.id});

  @override
  _Admin_PendudukScreenState createState() => _Admin_PendudukScreenState();
}

class _Admin_PendudukScreenState extends State<Admin_PendudukScreen> {
  final UploadPendudukanService _UploadPendudukanService =
      UploadPendudukanService();
  File? selectedDocument;
  bool _isImageVisibleKTP = false;
  bool _isImageVisibleKK = false;
  bool _isImageVisibleNikahPria = false;
  bool _isImageVisibleNikahWanita = false;
  late Future<Map<String, dynamic>?> _futurePendudukan;

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
    _futurePendudukan = getPendudukan();
  }

  Future<Map<String, dynamic>?> getPendudukan() async {
    String url =
        'http://10.0.2.2:8080/essentials_api/get_ad_pendudukan.php?id_pendudukan=${widget.id}';
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

    await _UploadPendudukanService.pendudukan(
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
          'Verifikasi Kependudukan',
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
        future: _futurePendudukan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Data tidak ditemukan"));
          }

          var pendudukan = snapshot.data!;
          String namaPemohon = pendudukan["nama"] ?? "Tidak diketahui";
          String noHpPemohon = pendudukan["no_hp"] ?? "Tidak diketahui";
          String emailPemohon = pendudukan["email"] ?? "Tidak diketahui";
          String tglUploadPemohon = pendudukan["pen_tgl_upload"] != null
              ? DateFormat('dd MMMM yyyy - HH:mm:ss').format(
                  DateTime.parse(pendudukan["pen_tgl_upload"]),
                )
              : "Tidak diketahui";
          String fotoKTP = pendudukan["pen_foto_ktp"] ?? "Tidak diketahui";
          String fotoKK = pendudukan["pen_foto_kk"] ?? "Tidak diketahui";
          String fotoNikahPria =
              pendudukan["pen_foto_nikah_pria"] ?? "Tidak diketahui";
          String fotoNikahWanita =
              pendudukan["pen_foto_nikah_wanita"] ?? "Tidak diketahui";
          String DaerahAsal =
              pendudukan["pen_daerah_asal"] ?? "Tidak diketahui";
          String DaerahTujuan =
              pendudukan["pen_daerah_tujuan"] ?? "Tidak diketahui";
          String konfirmasiData =
              pendudukan["pen_konfirmasi"] ?? "Tidak diketahui";

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
                    _imageNikahPria(fotoNikahPria),
                    const SizedBox(height: 12),
                    _imageNikahWanita(fotoNikahWanita),
                    const SizedBox(height: 12),
                    _daerahAsal(DaerahAsal),
                    const SizedBox(height: 12),
                    _daerahTujuan(DaerahTujuan),
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
                    if (konfirmasiData == "sudah") _konfirmasi(),
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

  Column _imageNikahPria(String NikahPria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto Buku Nikah Pria',
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
              child: NikahPria.isNotEmpty
                  ? Row(
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
                                    "Foto Buku Nikah Pria Tersedia",
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
                            _isImageVisibleNikahPria
                                ? PhosphorIcons.eye()
                                : PhosphorIcons.eyeSlash(),
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isImageVisibleNikahPria =
                                  !_isImageVisibleNikahPria;
                            });
                            _showDialogFotoNikahPria(context, NikahPria);
                          },
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Foto tidak tersedia",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red.withOpacity(0.8),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Column _imageNikahWanita(String NikahWanita) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto Buku Nikah Wanita',
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
              child: NikahWanita.isNotEmpty
                  ? Row(
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
                                    "Foto Buku Nikah Wanita Tersedia",
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
                            _isImageVisibleNikahWanita
                                ? PhosphorIcons.eye()
                                : PhosphorIcons.eyeSlash(),
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isImageVisibleNikahWanita =
                                  !_isImageVisibleNikahWanita;
                            });
                            _showDialogFotoNikahWanita(context, NikahWanita);
                          },
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Foto tidak tersedia",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red.withOpacity(0.8),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Column _daerahAsal(String Asal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daerah Asal Tinggal',
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
                Asal,
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

  Column _daerahTujuan(String Tujuan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daerah Tujuan Tinggal',
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
                Tujuan,
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

  void _showDialogFotoNikahPria(BuildContext context, String foto) {
    if (_isImageVisibleNikahPria) {
      _showImageDialog(context, foto, () => _isImageVisibleNikahPria = false);
    }
  }

  void _showDialogFotoNikahWanita(BuildContext context, String foto) {
    if (_isImageVisibleNikahWanita) {
      _showImageDialog(context, foto, () => _isImageVisibleNikahWanita = false);
    }
  }

  ImageProvider _getImageProvider(String foto) {
    if (foto.isEmpty) {
      return AssetImage('assets/images/no_image.jpg');
    }

    if (foto.startsWith('http')) {
      return NetworkImage(foto);
    }

    try {
      Uint8List bytes = base64Decode(foto);
      return MemoryImage(bytes);
    } catch (e) {
      print("Error decoding base64: $e");
      return AssetImage('assets/images/no_image.jpg');
    }
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
}
