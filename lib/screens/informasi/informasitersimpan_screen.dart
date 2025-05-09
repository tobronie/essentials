import 'dart:convert';
import 'package:essentials/screens/informasi/detailinformasi_screen.dart';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:essentials/services/save_information.dart';
import 'package:essentials/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SaveInformasiScreen extends StatefulWidget {
  const SaveInformasiScreen({super.key});

  @override
  _SaveInformasiScreenState createState() => _SaveInformasiScreenState();
}

class _SaveInformasiScreenState extends State<SaveInformasiScreen> {
  String _selectedOption = 'Semua';
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  FocusNode _searchFocusNode = FocusNode();
  late Future<List<dynamic>> futureInformation;

  @override
  void initState() {
    super.initState();
    futureInformation = getInformation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userSession = Provider.of<UserSession>(context, listen: false);
      print("User yang login: ${userSession.id_user ?? "Belum Login"}");
    });
    Provider.of<BookmarkProvider>(context, listen: false).loadBookmarks();
  }

  Future<List<dynamic>> getInformation() async {
    String url = 'https://essentials.my.id/view_information.php';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        title: Text(
          'Informasi tersimpan',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F9F9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xffF9F9F9),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _search(),
                const SizedBox(height: 18),
                FutureBuilder<List<dynamic>>(
                  future: futureInformation,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("Tidak ada data tersedia"));
                    } else {
                      return Column(
                        children: [
                          _option(snapshot.data!),
                          const SizedBox(height: 18),
                          _data(snapshot.data!),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _search() {
    return Container(
      height: 40,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xffD9D9D9),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Icon(PhosphorIconsRegular.magnifyingGlass, color: Color(0xff00AA13)),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: "Pencarian Anda ...",
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 11),
              ),
            ),
          ),
          SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _option(List<dynamic> data) {
    List<String> categories = [
      'Semua',
      'Infrastruktur',
      'Kecelakaan',
      'Kegiatan',
      'Sosial'
    ];

    return Container(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories
            .map((category) => _buildCategoryOption(category))
            .toList(),
      ),
    );
  }

  Widget _buildCategoryOption(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = category;
          _searchQuery = '';
          _searchController.clear();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: _selectedOption == category
              ? Color(0xff00AA13).withOpacity(0.25)
              : Colors.white,
          border: Border.all(
            color: _selectedOption == category
                ? Color(0xff00AA13)
                : Color(0xffD9D9D9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          category,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color:
                _selectedOption == category ? Color(0xff00AA13) : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _data(List<dynamic> informasiList) {
    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, child) {
        final userSession = Provider.of<UserSession>(context);
        List<dynamic> filteredList = informasiList.where((info) {
          bool matchesCategory = _selectedOption == 'Semua' ||
              info['kategori_info'] == _selectedOption;
          bool matchesSearch = info['judul_info']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

          bool isBookmarked = bookmarkProvider.isBookmarked(
            userSession.id_user ?? 'id_user',
            info['id_info'],
          );

          return matchesCategory && matchesSearch && isBookmarked;
        }).toList();

        filteredList.sort((a, b) {
          DateTime dateA =
              DateTime.tryParse(a['tgl_upload_info'] ?? '') ?? DateTime(1970);
          DateTime dateB =
              DateTime.tryParse(b['tgl_upload_info'] ?? '') ?? DateTime(1970);
          return dateB.compareTo(dateA);
        });

        return ListView.builder(
          itemCount: filteredList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var informasi = filteredList[index];

            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InformasiDetailScreen(
                          id: informasi['id_info'].toString(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 92,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                informasi['judul_info'] ?? '',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  height: 1.1,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    informasi['tgl_upload_info'] != null
                                        ? DateFormat('dd MMM yyyy').format(
                                            DateTime.parse(
                                                informasi['tgl_upload_info']),
                                          )
                                        : 'Tanggal tidak tersedia',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 6),
                                    decoration: BoxDecoration(
                                      color:
                                          Color(0xff00AA13).withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      PhosphorIcons.bookmarkSimple(),
                                      color: Color(0xff00AA13),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: _getImageProvider(
                                      informasi['foto_info'] ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2),
                SizedBox(
                  height: 1,
                  child: Container(
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ],
            );
          },
        );
      },
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
