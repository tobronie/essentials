import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:essentials/services/akte_services.dart';
import 'package:essentials/services/domisili_services.dart';
import 'package:essentials/services/kematian_services.dart';
import 'package:essentials/services/kk_services.dart';
import 'package:essentials/services/ktp_services.dart';
import 'package:essentials/services/nikah_services.dart';
import 'package:essentials/services/pendudukan_services.dart';
import 'package:essentials/services/penghasilan_ortu_services.dart';
import 'package:essentials/services/sktm_services.dart';
import 'package:essentials/services/tanah_services.dart';
import 'package:essentials/services/usaha_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ListVerifikasiAdministrasiAdminScreen extends StatefulWidget {
  const ListVerifikasiAdministrasiAdminScreen({super.key});

  @override
  _ListVerifikasiAdministrasiAdminScreenState createState() =>
      _ListVerifikasiAdministrasiAdminScreenState();
}

class _ListVerifikasiAdministrasiAdminScreenState
    extends State<ListVerifikasiAdministrasiAdminScreen> {
  String _selectedText = 'Dalam Proses';
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearchActive = false;
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("User ID: ${user.uid}");
    } else {
      print("No user is currently logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                _dataCollection('domisili'),
                _dataCollection('usaha'),
                _dataCollection('sktm'),
                _dataCollection('kematian'),
                _dataCollection('penghasilan_ortu'),
                _dataCollection('ktp'),
                _dataCollection('kk'),
                _dataCollection('akte'),
                _dataCollection('nikah'),
                _dataCollection('tanah'),
                _dataCollection('pendudukan'),
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
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                  _isSearchActive = query.isNotEmpty;
                  if (_isSearchActive) {
                    _selectedText = 'Dalam proses';
                  }
                });
              },
              onTap: () {
                setState(() {
                  _isSearchActive = true;
                  _selectedText = 'Dalam proses';
                });
              },
              decoration: InputDecoration(
                hintText: "Pencarian Anda ...",
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
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
                  _selectedText = 'Dalam Proses';
                });
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Text(
                    'Dalam Proses',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selectedText == 'Dalam Proses'
                          ? Color(0xFF0D0140)
                          : Colors.black,
                    ),
                  ),
                  if (_selectedText == 'Dalam Proses')
                    Container(
                      height: 2,
                      width: 'Dalam Proses'.length * 8.5,
                      color: Color(0xFF0D0140),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedText = 'Riwayat';
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
                      color: _selectedText == 'Riwayat'
                          ? Color(0xFF0D0140)
                          : Colors.black,
                    ),
                  ),
                  if (_selectedText == 'Riwayat')
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

  Widget _dataCollection(String collectionType) {
    Stream<QuerySnapshot> getStream() {
      switch (collectionType) {
        case 'domisili':
          return DbDomisili.getDataBySearch(_selectedText, _searchQuery);
        case 'usaha':
          return DbUsaha.getDataBySearch(_selectedText, _searchQuery);
        case 'sktm':
          return DbSKTM.getDataBySearch(_selectedText, _searchQuery);
        case 'kematian':
          return DbKematian.getDataBySearch(_selectedText, _searchQuery);
        case 'penghasilan_ortu':
          return DbPenghasilanOrtu.getDataBySearch(_selectedText, _searchQuery);
        case 'ktp':
          return DbKTP.getDataBySearch(_selectedText, _searchQuery);
        case 'kk':
          return DbKK.getDataBySearch(_selectedText, _searchQuery);
        case 'akte':
          return DbAkte.getDataBySearch(_selectedText, _searchQuery);
        case 'nikah':
          return DbNikah.getDataBySearch(_selectedText, _searchQuery);
        case 'tanah':
          return DbTanah.getDataBySearch(_selectedText, _searchQuery);
        case 'pendudukan':
          return DbPendudukan.getDataBySearch(_selectedText, _searchQuery);
        default:
          throw Exception('Jenis koleksi tidak diketahui');
      }
    }

    return StreamBuilder<QuerySnapshot>(
      stream: getStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final documents = snapshot.data!.docs;

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final data =
                          documents[index].data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          final String documentId = documents[index].id;
                          switch (collectionType) {
                            case 'domisili':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_DomisiliScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'usaha':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_UsahaScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'sktm':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_SKTMScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'kematian':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_KematianScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'penghasilan_ortu':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_PenghasilanScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'ktp':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_KTPScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'kk':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_KKScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'akte':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_AkteScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'nikah':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_NikahScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'tanah':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_TanahScreen(id: documentId),
                                ),
                              );
                              break;
                            case 'pendudukan':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_PendudukScreen(id: documentId),
                                ),
                              );
                              break;
                            default:
                              break;
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          height: 84,
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
                                data['judul'] ?? '',
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
                                data['nama'] ?? '',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
