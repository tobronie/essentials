import 'dart:convert';
import 'dart:typed_data';
import 'package:essentials/screens/administrasi/listadministrasi_screen.dart';
import 'package:essentials/screens/informasi/detailinformasi_screen.dart';
import 'package:essentials/screens/informasi/informasitetap.dart';
import 'package:essentials/screens/informasi/listinformasi_screen.dart';
import 'package:essentials/screens/navigation/notification_screen.dart';
import 'package:essentials/screens/pelaporan/formulirpelaporan_screen.dart';
import 'package:essentials/user_session.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:essentials/screens/navigation/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  late Future<List<dynamic>> futureInformation;
  late Future<List<dynamic>> futureInformationDesa;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userSession = Provider.of<UserSession>(context, listen: false);
      print("User yang login: ${userSession.id_user ?? "Belum Login"}");
    });
    futureInformation = getInformation();
    futureInformationDesa = getMemo();
    super.initState();
  }

  Future<List<dynamic>> getInformation() async {
    String url = 'http://10.0.2.2:8080/essentials_api/view_information.php';
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

  Future<Map<String, dynamic>?> getUser(String id_user) async {
    String url =
        'http://10.0.2.2:8080/essentials_api/get_user.php?id_user=$id_user';

    try {
      var response = await http.get(Uri.parse(url));
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Parsed Data: $data");

        if (data is List && data.isNotEmpty) {
          return data[0];
        } else if (data is Map<String, dynamic>) {
          return data;
        } else {
          throw Exception("Format data tidak valid");
        }
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<UserSession>(context, listen: false);

    return FutureBuilder<Map<String, dynamic>?>(
      future: getUser(userSession.id_user ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            body: Center(child: Text("Pengguna Tidak Ditemukan")),
          );
        }
        print(userSession.id_user);
        String userName = snapshot.data?["nama"]?.toString() ?? "Nama Pengguna";
        return Scaffold(
          backgroundColor: Color(0xffF9F9F9),
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: 382,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff00AA13).withOpacity(0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 4),
                        _appBar(userName),
                        const SizedBox(height: 18),
                        _welcomeBanner(),
                        const SizedBox(height: 18),
                        _homeMenu(context),
                        const SizedBox(height: 18),
                        _homeInformasi(),
                        const SizedBox(height: 18),
                        _homeDesa(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomNavigationBar(selectedIndex: 0),
        );
      },
    );
  }

  Widget _appBar(String nama) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              Text(
                nama,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xff00AA13),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotifikasiScreen()),
                  );
                },
                child: const Icon(
                  PhosphorIconsRegular.bell,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _welcomeBanner() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/home.png',
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _homeMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PelaporanScreen()),
              );
            },
            child: Column(
              children: [
                Image.asset(
                  'assets/images/icon_laporan.png',
                  width: 70,
                  height: 70,
                ),
                const SizedBox(height: 2),
                Text(
                  'Pengaduan',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdministrasiScreen()),
              );
            },
            child: Column(
              children: [
                Image.asset(
                  'assets/images/icon_administrasi.png',
                  width: 70,
                  height: 70,
                ),
                const SizedBox(height: 2),
                Text(
                  'Administrasi',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformasiScreen()),
              );
            },
            child: Column(
              children: [
                Image.asset(
                  'assets/images/icon_informasi.png',
                  width: 70,
                  height: 70,
                ),
                const SizedBox(height: 2),
                Text(
                  'Informasi',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeInformasi() {
    return FutureBuilder<List<dynamic>>(
      future: futureInformation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Tidak ada data tersedia"));
        }

        List<dynamic> informasiList = snapshot.data!;
        informasiList.sort((a, b) => DateTime.parse(b['tgl_upload_info'])
            .compareTo(DateTime.parse(a['tgl_upload_info'])));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cek informasi menarik lainnya',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 156,
              child: ListView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: informasiList.length > 5 ? 5 : informasiList.length,
                itemBuilder: (context, index) {
                  var informasi = informasiList[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 2, right: 12, top: 2),
                    child: GestureDetector(
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
                        width: 274,
                        height: 152,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 3,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: _getImageProvider(
                                    informasi['foto_info'] ?? ''),
                                width: 274,
                                height: 152,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 152,
                                height: 152,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        informasi['kategori_info'] ?? '',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        informasi['judul_info'] ?? '',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          height: 1.2,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                      ),
                                      const SizedBox(height: 12),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Container(
                                          height: 2,
                                          width: 42,
                                          color: const Color(0xff00AA13),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        informasi['tgl_upload_info'] != null
                                            ? DateFormat('dd MMM yyyy').format(
                                                DateTime.parse(informasi[
                                                    'tgl_upload_info']),
                                              )
                                            : 'Tanggal tidak tersedia',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: informasiList.length > 5 ? 5 : informasiList.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 5,
                  dotWidth: 5,
                  activeDotColor: Color(0xff00AA13),
                  dotColor: Colors.grey.shade400,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _homeDesa() {
    return FutureBuilder<List<dynamic>>(
      future: futureInformationDesa,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Tidak ada data tersedia"));
        }

        List<dynamic> informasiDesaList = snapshot.data!;
        informasiDesaList.sort((a, b) => DateTime.parse(b['tgl_upload_infodes'])
            .compareTo(DateTime.parse(a['tgl_upload_infodes'])));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Memo Desa Kedungmulyo',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(
              informasiDesaList.length > 2 ? 2 : informasiDesaList.length,
              (index) {
                Map<String, dynamic> informasiDesa = informasiDesaList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InformasiTetapScreen(
                            id: informasiDesa['id_infodes'].toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 3,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image(
                              image: _getImageProvider(
                                  informasiDesa['foto_infodes'] ?? ''),
                              width: double.infinity,
                              height: 140,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  informasiDesa['judul_infodes'] ?? '',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  informasiDesa['isi_infodes'] ?? '',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    height: 1.2,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
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
}
