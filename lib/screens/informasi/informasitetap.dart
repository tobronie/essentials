import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class InformasiTetapScreen extends StatefulWidget {
  final String id;

  const InformasiTetapScreen({super.key, required this.id});

  @override
  _InformasiTetapScreenState createState() => _InformasiTetapScreenState();
}

class _InformasiTetapScreenState extends State<InformasiTetapScreen> {
  late Future<List<dynamic>> _futureInformationDesa;
  Map<String, dynamic>? _sharedInformationDesa;

  @override
  void initState() {
    super.initState();
    _futureInformationDesa = getInformationDesa();
  }

  Future<List<dynamic>> getInformationDesa() async {
    String url =
        'http://10.0.2.2:8080/essentials_api/get_information_desa.php?id_infodes=${widget.id}';
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          _sharedInformationDesa = data[0];
        }
        return data;
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<void> shareImageFromBase64(String base64Image, String judul) async {
    try {
      Uint8List imageBytes = base64Decode(base64Image);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/foto_informasi.jpg');
      await file.writeAsBytes(imageBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: '$judul\n\nInformasi Selengkapnya di Aplikasi "Essentials"',
      );
    } catch (e) {
      print("Gagal membagikan gambar: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: IconButton(
              icon: const Icon(PhosphorIconsRegular.arrowBendUpRight,
                  color: Colors.black),
              onPressed: () {
                if (_sharedInformationDesa != null) {
                  shareImageFromBase64(_sharedInformationDesa!['foto_infodes'],
                      _sharedInformationDesa!['judul_infodes']);
                }
              },
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
        backgroundColor: const Color(0xffF9F9F9),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureInformationDesa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text("Data tidak ditemukan"));
          }

          var informationDesa = snapshot.data![0];

          return SafeArea(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _getImageProvider_infodes(
                          informationDesa['foto_infodes'] ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.only(top: 216),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 3,
                          width: 40,
                          color: const Color(0xff00AA13),
                        ),
                        const SizedBox(height: 32),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            informationDesa['judul_infodes'] ?? '',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            height: 2,
                            width: 118,
                            color: const Color(0xffD9D9D9),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: 
                            Text(
                              informationDesa['tgl_upload_infodes'] != null
                                  ? DateFormat('dd MMMM yyyy').format(
                                      DateTime.parse(
                                          informationDesa['tgl_upload_infodes']),
                                    )
                                  : 'Tanggal tidak tersedia',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            informationDesa['isi_infodes'] ?? '',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
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
          );
        },
      ),
    );
  }

  ImageProvider _getImageProvider_infodes(String fotoInfoDesa) {
    if (fotoInfoDesa.isEmpty) {
      return const AssetImage('assets/images/no_image.jpg');
    }
    if (fotoInfoDesa.startsWith('http')) {
      return NetworkImage(fotoInfoDesa);
    }
    try {
      Uint8List bytes = base64Decode(fotoInfoDesa);
      return MemoryImage(bytes);
    } catch (e) {
      print("Error decoding base64: $e");
      return const AssetImage('assets/images/no_image.jpg');
    }
  }
}
