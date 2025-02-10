import 'dart:convert';
import 'dart:typed_data';
import 'package:essentials/screens/admin/tambahmemo_admin_screen.dart';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;

class MemoDesaAdminScreen extends StatefulWidget {
  const MemoDesaAdminScreen({super.key});

  @override
  _MemoDesaAdminScreenState createState() => _MemoDesaAdminScreenState();
}

class _MemoDesaAdminScreenState extends State<MemoDesaAdminScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  FocusNode _searchFocusNode = FocusNode();

  Future<List<dynamic>> getMemo() async {
    String url =
        'http://10.0.2.2:8080/essentials_api/view_information_desa.php';
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
          'Memo Desa',
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
                _searchAndCread(),
                const SizedBox(height: 18),
                FutureBuilder<List<dynamic>>(
                  future: getMemo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("Tidak ada data tersedia"));
                    } else {
                      return _data(snapshot.data!);
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

  Widget _searchAndCread() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
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
                Icon(PhosphorIconsRegular.magnifyingGlass,
                    color: Color(0xFF0D0140)),
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
          ),
        ),
        SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xffD9D9D9),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                PhosphorIconsRegular.notePencil,
                color: Color(0xFF0D0140),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TambahMemoScreen(),
                  ),
                );
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _data(List<dynamic> memoList) {
    List<dynamic> filteredList = memoList.where((memo) {
      bool matchesSearch = memo['judul_infodes']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());

      return matchesSearch;
    }).toList();

    filteredList.sort((a, b) {
      DateTime dateA =
          DateTime.tryParse(a['tgl_upload_infodes'] ?? '') ?? DateTime(1970);
      DateTime dateB =
          DateTime.tryParse(b['tgl_upload_infodes'] ?? '') ?? DateTime(1970);
      return dateB.compareTo(dateA);
    });

    return ListView.builder(
      itemCount: filteredList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var information_desa = filteredList[index];

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                //detail infodes
              },
              child: Container(
                width: double.infinity,
                height: 92,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              information_desa['judul_infodes'] ?? '',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                height: 1.1,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  information_desa['tgl_upload_infodes'] != null
                                      ? DateFormat('dd MMM yyyy').format(
                                          DateTime.parse(information_desa[
                                              'tgl_upload_infodes']),
                                        )
                                      : 'Tanggal tidak tersedia',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        //edit infodes
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 6),
                                        decoration: BoxDecoration(
                                          color:
                                              Color(0xFF9D00).withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          PhosphorIcons.pencilSimpleLine(),
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        //delete infodes
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 6),
                                        decoration: BoxDecoration(
                                          color:
                                              Color(0xFF0000).withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          PhosphorIcons.trash(),
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
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
                                  information_desa['foto_infodes'] ?? ''),
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
  }

  ImageProvider _getImageProvider(String fotoInfo) {
    if (fotoInfo.isEmpty) {
      return AssetImage('assets/images/no_image.jpg');
    }

    if (fotoInfo.startsWith('http')) {
      return NetworkImage(fotoInfo);
    }

    try {
      Uint8List bytes = base64Decode(fotoInfo);
      return MemoryImage(bytes);
    } catch (e) {
      print("Error decoding base64: $e");
      return AssetImage('assets/images/no_image.jpg');
    }
  }
}
