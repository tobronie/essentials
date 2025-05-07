import 'package:essentials/services/save_information.dart';
import 'package:essentials/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class InformasiDetailScreen extends StatefulWidget {
  final String id;

  const InformasiDetailScreen({super.key, required this.id});

  @override
  _InformasiDetailScreenState createState() => _InformasiDetailScreenState();
}

class _InformasiDetailScreenState extends State<InformasiDetailScreen> {
  late Future<List<dynamic>> _futureInformation;
  Map<String, dynamic>? _sharedInformation;

  @override
  void initState() {
    super.initState();
    _futureInformation = getInformation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userSession = Provider.of<UserSession>(context, listen: false);
      print("User yang login: ${userSession.id_user ?? "Belum Login"}");
    });
    Provider.of<BookmarkProvider>(context, listen: false).loadBookmarks();
  }

  Future<List<dynamic>> getInformation() async {
    String url =
        'https://essentials.my.id/get_information.php?id_info=${widget.id}';
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          _sharedInformation = data[0];
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

  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<UserSession>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    bool isBookmarked =
        bookmarkProvider.isBookmarked(userSession.id_user ?? '', widget.id);
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
                if (_sharedInformation != null) {
                  shareImageFromBase64(_sharedInformation!['foto_info'],
                      _sharedInformation!['judul_info']);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              icon: Icon(
                isBookmarked
                    ? Icons.bookmark
                    : PhosphorIconsRegular.bookmarkSimple,
                color: isBookmarked ? Color(0xff00AA13) : Colors.black,
              ),
              onPressed: () {
                bool isAlreadyBookmarked = bookmarkProvider.isBookmarked(
                    userSession.id_user ?? '', widget.id);

                if (isAlreadyBookmarked) {
                  print('Data sudah ada di bookmark. Menghapus bookmark...');
                  bookmarkProvider.removeBookmark(
                      userSession.id_user ?? '', widget.id);
                } else {
                  print('Data belum ada di bookmark. Menambahkan bookmark...');
                  bookmarkProvider.addBookmark(
                      userSession.id_user ?? '', widget.id);
                }
                setState(() {
                  isBookmarked = !isBookmarked;
                });
                print(
                    'Status bookmark setelah aksi: ${bookmarkProvider.isBookmarked(userSession.id_user ?? '', widget.id)}');
              },
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: const Color(0xffF9F9F9),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureInformation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text("Data tidak ditemukan"));
          }

          var information = snapshot.data![0];

          return SafeArea(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _getImageProvider(information['foto_info'] ?? ''),
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
                            information['judul_info'] ?? '',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              information['kategori_info'] ?? '',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text('-'),
                            const SizedBox(width: 4),
                            Text(
                              information['tgl_upload_info'] != null
                                  ? DateFormat('dd MMMM yyyy').format(
                                      DateTime.parse(
                                          information['tgl_upload_info']),
                                    )
                                  : 'Tanggal tidak tersedia',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            information['isi_info'] ?? '',
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
}
