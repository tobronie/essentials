import 'package:essentials/screens/admin/administrasi_admin/admin_akte_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_domisili_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_kematian_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_kk_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_ktp_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_nikah_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_penduduk_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_penghasilan_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_sktm_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_tanah_screen.dart';
import 'package:essentials/screens/admin/administrasi_admin/admin_usaha_screen.dart';
import 'package:essentials/screens/admin/navigation_admin.dart';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class ListVerifikasiAdministrasiAdminScreen extends StatefulWidget {
  const ListVerifikasiAdministrasiAdminScreen({super.key});

  @override
  _ListVerifikasiAdministrasiAdminScreenState createState() =>
      _ListVerifikasiAdministrasiAdminScreenState();
}

class _ListVerifikasiAdministrasiAdminScreenState
    extends State<ListVerifikasiAdministrasiAdminScreen> {
  String _selectedProses = 'Dalam Verifikasi';
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  FocusNode _searchFocusNode = FocusNode();
  late Future<List<List<dynamic>>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getAllData();
  }

  Future<List<dynamic>> fetchData(String endpoint) async {
    String url = 'http://10.0.2.2:8080/essentials_api/$endpoint';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Gagal mengambil data dari $endpoint');
      }
    } catch (e) {
      print("Error fetching $endpoint: $e");
      return [];
    }
  }

  Future<List<List<dynamic>>> getAllData() async {
    return await Future.wait([
      fetchData('khusus_view_ad_akte.php'),
      fetchData('khusus_view_ad_domisili.php'),
      fetchData('khusus_view_ad_kematian.php'),
      fetchData('khusus_view_ad_kk.php'),
      fetchData('khusus_view_ad_ktp.php'),
      fetchData('khusus_view_ad_nikah.php'),
      fetchData('khusus_view_ad_pendudukan.php'),
      fetchData('khusus_view_ad_penghasilan_ortu.php'),
      fetchData('khusus_view_ad_sktm.php'),
      fetchData('khusus_view_ad_tanah.php'),
      fetchData('khusus_view_ad_usaha.php'),
    ]);
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
        return DateFormat('dd MMMM yyyy').format(DateTime.parse(rawDate));
      } catch (e) {
        return 'Format tanggal tidak valid';
      }
    }
    return 'Tanggal tidak tersedia';
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
          'Verifikasi Administrasi',
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
                _process(context),
                const SizedBox(height: 18),
                FutureBuilder<List<List<dynamic>>>(
                  future: _futureData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return Center(child: Text("Tidak ada data tersedia"));
                    }

                    final data = snapshot.data!;
                    return _data(
                      data[0],
                      data[1],
                      data[2],
                      data[3],
                      data[4],
                      data[5],
                      data[6],
                      data[7],
                      data[8],
                      data[9],
                      data[10],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AdminCustomNavigationBar(selectedIndex: 1),
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
          Icon(PhosphorIconsRegular.magnifyingGlass, color: Color(0xFF0D0140)),
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

  Widget _process(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedProses = 'Dalam Verifikasi';
                });
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Text(
                    'Dalam Verifikasi',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selectedProses == 'Dalam Verifikasi'
                          ? Color(0xFF0D0140)
                          : Colors.black,
                    ),
                  ),
                  if (_selectedProses == 'Dalam Verifikasi')
                    Container(
                      height: 2,
                      width: 'Dalam Verifikasi'.length * 7.5,
                      color: Color(0xFF0D0140),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedProses = 'Terverifikasi';
                });
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Text(
                    'Terverifikasi',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selectedProses == 'Terverifikasi'
                          ? Color(0xFF0D0140)
                          : Colors.black,
                    ),
                  ),
                  if (_selectedProses == 'Terverifikasi')
                    Container(
                      height: 2,
                      width: 'Terverifikasi'.length * 6.7,
                      color: Color(0xFF0D0140),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedProses = 'Riwayat';
                });
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Text(
                    'Riwayat',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selectedProses == 'Riwayat'
                          ? Color(0xFF0D0140)
                          : Colors.black,
                    ),
                  ),
                  if (_selectedProses == 'Riwayat')
                    Container(
                      height: 2,
                      width: 'Riwayat'.length * 8.5,
                      color: Color(0xFF0D0140),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _data(
      List<dynamic> akteList,
      List<dynamic> domisiliList,
      List<dynamic> kematianList,
      List<dynamic> kkList,
      List<dynamic> ktpList,
      List<dynamic> nikahList,
      List<dynamic> pendudukanList,
      List<dynamic> penghasilanOrtuList,
      List<dynamic> sktmList,
      List<dynamic> tanahList,
      List<dynamic> usahaList) {
    List<dynamic> combinedList = [
      ...akteList,
      ...domisiliList,
      ...kematianList,
      ...kkList,
      ...ktpList,
      ...nikahList,
      ...pendudukanList,
      ...penghasilanOrtuList,
      ...sktmList,
      ...tanahList,
      ...usahaList,
    ];

    if (_selectedProses == "Dalam Verifikasi") {
      combinedList = combinedList.where((item) {
        return [
          'konfirmasi_lapor',
          'ak_konfirmasi',
          'dom_konfirmasi',
          'kem_konfirmasi',
          'kk_konfirmasi',
          'kt_konfirmasi',
          'ni_konfirmasi',
          'pen_konfirmasi',
          'has_konfirmasi',
          'sktm_konfirmasi',
          'tan_konfirmasi',
          'us_konfirmasi'
        ].any((key) {
          var value = item[key];
          return value != null && value.toString().contains("menunggu");
        });
      }).toList();
    } else if (_selectedProses == "Terverifikasi") {
      combinedList = combinedList.where((item) {
        bool hasVerified = [
          'konfirmasi_lapor',
          'ak_konfirmasi',
          'dom_konfirmasi',
          'kem_konfirmasi',
          'kk_konfirmasi',
          'kt_konfirmasi',
          'ni_konfirmasi',
          'pen_konfirmasi',
          'has_konfirmasi',
          'sktm_konfirmasi',
          'tan_konfirmasi',
          'us_konfirmasi'
        ].any((key) {
          var value = item[key];
          return value != null && value.toString().contains("sudah");
        });

        bool noSuratKonfirmasi = [
          'ak_surat_konfirmasi',
          'dom_surat_konfirmasi',
          'kem_surat_konfirmasi',
          'kk_surat_konfirmasi',
          'kt_surat_konfirmasi',
          'ni_surat_konfirmasi',
          'pen_surat_konfirmasi',
          'has_surat_konfirmasi',
          'sktm_surat_konfirmasi',
          'tan_surat_konfirmasi',
          'us_surat_konfirmasi'
        ].every((key) {
          var value = item[key];
          return value == null || value.toString().isEmpty;
        });

        return hasVerified && noSuratKonfirmasi;
      }).toList();
    } else if (_selectedProses == "Riwayat") {
      combinedList = combinedList.where((item) {
        return [
              'konfirmasi_lapor',
              'ak_konfirmasi',
              'dom_konfirmasi',
              'kem_konfirmasi',
              'kk_konfirmasi',
              'kt_konfirmasi',
              'ni_konfirmasi',
              'pen_konfirmasi',
              'has_konfirmasi',
              'sktm_konfirmasi',
              'tan_konfirmasi',
              'us_konfirmasi'
            ].any((key) {
              var value = item[key];
              return value != null && value.toString().contains("tidak");
            }) ||
            [
              'ak_surat_konfirmasi',
              'dom_surat_konfirmasi',
              'kem_surat_konfirmasi',
              'kk_surat_konfirmasi',
              'kt_surat_konfirmasi',
              'ni_surat_konfirmasi',
              'pen_surat_konfirmasi',
              'has_surat_konfirmasi',
              'sktm_surat_konfirmasi',
              'tan_surat_konfirmasi',
              'us_surat_konfirmasi'
            ].any((key) {
              var value = item[key];
              return value != null && value.toString().isNotEmpty;
            });
      }).toList();
    }

    List<dynamic> filteredList = combinedList.where((item) {
      String query = _searchQuery.toLowerCase();
      return [
        'ak_judul',
        'dom_judul',
        'kem_judul',
        'kk_judul',
        'kt_judul',
        'ni_judul',
        'pen_judul',
        'has_judul',
        'sktm_judul',
        'tan_judul',
        'us_judul'
      ].any(
          (key) => (item[key]?.toString() ?? '').toLowerCase().contains(query));
    }).toList();

    filteredList.sort((a, b) {
      DateTime getLatestDate(Map<String, dynamic> item) {
        List<String> dateKeys = [
          'ak_tgl_upload',
          'dom_tgl_upload',
          'kem_tgl_upload',
          'kk_tgl_upload',
          'kt_tgl_upload',
          'ni_tgl_upload',
          'pen_tgl_upload',
          'has_tgl_upload',
          'sktm_tgl_upload',
          'tan_tgl_upload',
          'us_tgl_upload'
        ];

        DateTime latestDate = DateTime(1970);
        for (String key in dateKeys) {
          DateTime? date = DateTime.tryParse(item[key] ?? '');
          if (date != null && date.isAfter(latestDate)) {
            latestDate = date;
          }
        }
        return latestDate;
      }

      return getLatestDate(b).compareTo(getLatestDate(a));
    });

    return ListView.builder(
      itemCount: filteredList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = filteredList[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Map<String, Widget Function(String)> screenMap = {
                  'id_akte': (id) => Admin_AkteScreen(id: id),
                  'id_domisili': (id) => Admin_DomisiliScreen(id: id),
                  'id_kematian': (id) => Admin_KematianScreen(id: id),
                  'id_kk': (id) => Admin_KKScreen(id: id),
                  'id_ktp': (id) => Admin_KTPScreen(id: id),
                  'id_nikah': (id) => Admin_NikahScreen(id: id),
                  'id_pendudukan': (id) => Admin_PendudukScreen(id: id),
                  'id_penghasilan': (id) => Admin_PenghasilanScreen(id: id),
                  'id_sktm': (id) => Admin_SKTMScreen(id: id),
                  'id_tanah': (id) => Admin_TanahScreen(id: id),
                  'id_usaha': (id) => Admin_UsahaScreen(id: id),
                };

                Map<String, String?> idMap = {
                  'id_akte': item['id_akte']?.toString(),
                  'id_domisili': item['id_domisili']?.toString(),
                  'id_kematian': item['id_kematian']?.toString(),
                  'id_kk': item['id_kk']?.toString(),
                  'id_ktp': item['id_ktp']?.toString(),
                  'id_nikah': item['id_nikah']?.toString(),
                  'id_pendudukan': item['id_pendudukan']?.toString(),
                  'id_penghasilan': item['id_penghasilan']?.toString(),
                  'id_sktm': item['id_sktm']?.toString(),
                  'id_tanah': item['id_tanah']?.toString(),
                  'id_usaha': item['id_usaha']?.toString(),
                };

                var selectedEntry = idMap.entries.firstWhere(
                  (entry) => entry.value != null && entry.value!.isNotEmpty,
                  orElse: () => MapEntry('', ''),
                );

                if (selectedEntry.key.isNotEmpty &&
                    selectedEntry.value!.isNotEmpty) {
                  var screenBuilder = screenMap[selectedEntry.key];

                  if (screenBuilder != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            screenBuilder(selectedEntry.value!),
                      ),
                    );
                  } else {
                    print("Screen tidak ditemukan untuk ${selectedEntry.key}");
                  }
                } else {
                  print("Tidak ada ID yang tersedia.");
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                height: 76,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                          '',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        height: 1.1,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 2,
                      width: 60,
                      color: const Color(0xFF0D0140),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatTanggal(item),
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
