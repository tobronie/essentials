import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ActivityPelaporanScreen extends StatefulWidget {
  final String id;

  const ActivityPelaporanScreen({super.key, required this.id});

  @override
  _ActivityPelaporanScreenState createState() =>
      _ActivityPelaporanScreenState();
}

class _ActivityPelaporanScreenState extends State<ActivityPelaporanScreen> {
  bool _isImageVisible = false;
  bool isLoading = true;
  late Future<Map<String, dynamic>?> _futurePelaporan;

  @override
  void initState() {
    super.initState();
    _futurePelaporan = getPelaporan();
  }

  Future<Map<String, dynamic>?> getPelaporan() async {
    String url =
        'http://10.0.2.2:8080/essentials_api/get_pelaporan.php?id_lapor=${widget.id}';
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
          'Pengaduan Anda',
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
        future: _futurePelaporan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Data tidak ditemukan"));
          }

          var pelaporan = snapshot.data!;
          String tglUploadPengadu = pelaporan["tgl_upload_lapor"] != null
              ? DateFormat('dd MMMM yyyy - HH:mm:ss').format(
                  DateTime.parse(pelaporan["tgl_upload_lapor"]),
                )
              : "Tidak diketahui";
          String fotoPengadu = pelaporan["foto_lapor"] ?? "Tidak diketahui";
          String judulPengadu = pelaporan["judul_lapor"] ?? "Tidak diketahui";
          String waktuKejadianPengadu =
              pelaporan["waktu_lapor"] ?? "Tidak diketahui";
          String lokasiPengadu = pelaporan["lokasi_lapor"] ?? "Tidak diketahui";
          String isiPengadu = pelaporan["isi_lapor"] ?? "Tidak diketahui";
          String konfirmasiData =
              pelaporan["konfirmasi_lapor"] ?? "Tidak diketahui";

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
                    _tglUploadLapor(tglUploadPengadu),
                    const SizedBox(height: 12),
                    _fotoLapor(fotoPengadu),
                    const SizedBox(height: 12),
                    _judulLapor(judulPengadu),
                    const SizedBox(height: 12),
                    _waktuKejadianLapor(waktuKejadianPengadu),
                    const SizedBox(height: 12),
                    _lokasiLapor(lokasiPengadu),
                    const SizedBox(height: 12),
                    _isiLapor(isiPengadu),
                    const SizedBox(height: 24),
                    _verification(konfirmasiData),
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

  Column _tglUploadLapor(String tglUpload) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waktu Upload Pengaduan',
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

  Column _fotoLapor(String foto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Foto Kejadian',
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
                          "foto berhasil diupload",
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
                ),
              ),
              IconButton(
                icon: Icon(
                  _isImageVisible
                      ? PhosphorIcons.eye()
                      : PhosphorIcons.eyeSlash(),
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _isImageVisible = !_isImageVisible;
                  });
                  _showImageDialog(context, foto);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, String fotoLapor) {
    if (_isImageVisible) {
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
                image: _getImageProvider(fotoLapor),
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ).then((_) {
        setState(() {
          _isImageVisible = false;
        });
      });
    }
  }

  ImageProvider _getImageProvider(String fotoLapor) {
    if (fotoLapor.isEmpty) {
      return AssetImage('assets/images/no_image.jpg');
    }

    if (fotoLapor.startsWith('http')) {
      return NetworkImage(fotoLapor);
    }

    try {
      Uint8List bytes = base64Decode(fotoLapor);
      return MemoryImage(bytes);
    } catch (e) {
      print("Error decoding base64: $e");
      return AssetImage('assets/images/no_image.jpg');
    }
  }

  Column _judulLapor(String judul) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Judul Pengaduan',
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
            judul,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Column _waktuKejadianLapor(String waktu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Waktu Kejadian',
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
            waktu,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Column _lokasiLapor(String lokasi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lokasi Kejadian',
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
            lokasi,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Column _isiLapor(String isi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Isi Pengaduan',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 100,
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
            isi,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  Container _verification(String konfirmasi) {
    String statusText = "";
    Color statusColor = Colors.black;

    switch (konfirmasi) {
      case "menunggu":
        statusText = "Menunggu diverifikasi";
        statusColor = const Color(0xffFF9D00);
        break;
      case "sudah":
        statusText = "Telah diverifikasi";
        statusColor = const Color(0xff00AA13);
        break;
      default:
        statusText = "Status tidak diketahui";
        statusColor = Colors.black;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "$statusText ",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.1,
                color: statusColor,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
