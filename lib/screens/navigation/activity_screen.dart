import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/screens/navigation/activityadministrasi_screen.dart';
import 'package:essentials/screens/navigation/activitypelaporan_screen.dart';
import 'package:essentials/services/akte_services.dart';
import 'package:essentials/services/domisili_services.dart';
import 'package:essentials/services/kematian_services.dart';
import 'package:essentials/services/kk_services.dart';
import 'package:essentials/services/ktp_services.dart';
import 'package:essentials/services/nikah_services.dart';
import 'package:essentials/services/pelaporan_services.dart';
import 'package:essentials/services/pendudukan_services.dart';
import 'package:essentials/services/penghasilan_ortu_services.dart';
import 'package:essentials/services/sktm_services.dart';
import 'package:essentials/services/tanah_services.dart';
import 'package:essentials/services/usaha_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:essentials/screens/navigation/navigation.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _selectedText = 'Dalam Proses';
  String _selectedOption = 'Semua';
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearchActive = false;
  FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Activity',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
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
                _option(context),
                const SizedBox(height: 18),
                _dataCollection('pelaporan'),
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
                _dataCollection('kependudukan'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(selectedIndex: 1),
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
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                  _isSearchActive = query.isNotEmpty;
                  if (_isSearchActive) {
                    _selectedOption = 'Semua';
                  }
                });
              },
              onTap: () {
                setState(() {
                  _isSearchActive = true;
                  _selectedOption = 'Semua';
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
                          ? Color(0xff00AA13)
                          : Colors.black,
                    ),
                  ),
                  if (_selectedText == 'Dalam Proses')
                    Container(
                      height: 2,
                      width: 'Dalam Proses'.length * 8.5,
                      color: Color(0xff00AA13),
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
                          ? Color(0xff00AA13)
                          : Colors.black,
                    ),
                  ),
                  if (_selectedText == 'Riwayat')
                    Container(
                      height: 2,
                      width: 'Riwayat'.length * 8.5,
                      color: Color(0xff00AA13),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _option(BuildContext context) {
    return Container(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryOption('Semua'),
          if (!_isSearchActive) ...[
            _buildCategoryOption('Administrasi'),
            _buildCategoryOption('Pengaduan'),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryOption(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = category;
          _searchQuery = '';
          _isSearchActive = false;
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

  Widget _dataCollection(String collectionType) {
    String collectionTitle = '';

    Stream<QuerySnapshot> getStream() {
      switch (collectionType) {
        case 'pelaporan':
          return DbPelaporan.getDataBySearch(_selectedOption, _searchQuery);
        case 'domisili':
          collectionTitle = 'Surat Keterangan Domisili';
          return DbDomisili.getDataBySearch(_selectedOption, _searchQuery);
        case 'usaha':
          collectionTitle = 'Surat Keterangan Usaha';
          return DbUsaha.getDataBySearch(_selectedOption, _searchQuery);
        case 'sktm':
          collectionTitle = 'Surat Keterangan Tidak Mampu';
          return DbSKTM.getDataBySearch(_selectedOption, _searchQuery);
        case 'kematian':
          collectionTitle = 'Surat Keterangan Kematian';
          return DbKematian.getDataBySearch(_selectedOption, _searchQuery);
        case 'penghasilan_ortu':
          collectionTitle = 'Surat Penghasilan Orang Tua';
          return DbPenghasilanOrtu.getDataBySearch(_selectedOption, _searchQuery);
        case 'ktp':
          collectionTitle = 'Kartu Tanda Penduduk';
          return DbKTP.getDataBySearch(_selectedOption, _searchQuery);
        case 'kk':
          collectionTitle = 'Kartu Keluarga';
          return DbKK.getDataBySearch(_selectedOption, _searchQuery);
        case 'akte':
          collectionTitle = 'Akte Kelahiran';
          return DbAkte.getDataBySearch(_selectedOption, _searchQuery);
        case 'nikah':
          collectionTitle = 'Pernikahan';
          return DbNikah.getDataBySearch(_selectedOption, _searchQuery);
        case 'tanah':
          collectionTitle = 'Pengantar Harga Tanah';
          return DbTanah.getDataBySearch(_selectedOption, _searchQuery);
        case 'kependudukan':
          collectionTitle = 'Surat Pindah atau Datang';
          return DbPendudukan.getDataBySearch(_selectedOption, _searchQuery);
        default:
          throw Exception('Unknown collection type');
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
                    String formattedDate = '';
                    if (data['tgl_upload'] is Timestamp) {
                      DateTime date =
                          (data['tgl_upload'] as Timestamp).toDate();
                      formattedDate = DateFormat('dd MMM yyyy').format(date);
                    } else {
                      formattedDate = data['tgl_upload'] ?? '';
                    }

                    if (collectionType == 'pelaporan') {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActivityPelaporanScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          height: 114,
                          padding: const EdgeInsets.all(8),
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
                          child: Row(
                            children: [
                              Container(
                                width: 98,
                                height: 98,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    data['image'] ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['judul'] ?? '',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: 2,
                                        width: 60,
                                        color: const Color(0xff00AA13),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formattedDate,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ActivityAdministrasiScreen(),
                            ),
                          );
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
                                collectionTitle,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  height: 1.1,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 2,
                                width: 60,
                                color: const Color(0xff00AA13),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formattedDate,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
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
