import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/screens/admin/editinformasi_admin_screen.dart';
import 'package:essentials/screens/admin/navigation_admin.dart';
import 'package:essentials/screens/admin/tambahinformasi_admin_screen.dart';
import 'package:essentials/screens/informasi/detailinformasi_screen.dart';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:essentials/services/information_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ListInformasiAdminScreen extends StatefulWidget {
  const ListInformasiAdminScreen({super.key});

  @override
  _ListInformasiAdminScreenState createState() =>
      _ListInformasiAdminScreenState();
}

class _ListInformasiAdminScreenState extends State<ListInformasiAdminScreen> {
  String _selectedOption = 'Semua';
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
          'Pengaturan Informasi',
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
                _option(context),
                const SizedBox(height: 18),
                _data(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AdminCustomNavigationBar(selectedIndex: 2),
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
                    builder: (context) => TambahInformasiScreen(),
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

  Widget _option(BuildContext context) {
    return Container(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryOption('Semua'),
          if (!_isSearchActive) ...[
            _buildCategoryOption('Infrastruktur'),
            _buildCategoryOption('Kecelakaan'),
            _buildCategoryOption('Kegiatan'),
            _buildCategoryOption('Sosial'),
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
              ? Color(0xFF0D0140).withOpacity(0.25)
              : Colors.white,
          border: Border.all(
            color: _selectedOption == category
                ? Color(0xFF0D0140)
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
                _selectedOption == category ? Color(0xFF0D0140) : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _data() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: DbInformation.getDataByCategoryAndSearch(
                _selectedOption, _searchQuery),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot information = documents[index];

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InformasiDetailScreen(
                                  information: information.data()
                                      as Map<String, dynamic>,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 92,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          information['judul'] ?? '',
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
                                              information['tgl_upload'] != null
                                                  ? DateFormat('dd MMM yyyy')
                                                      .format(
                                                      (information['tgl_upload']
                                                              as Timestamp)
                                                          .toDate(),
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
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditInformasiScreen(
                                                          editInformation:
                                                              information.data()
                                                                  as Map<String,
                                                                      dynamic>,
                                                          documentId:
                                                              information.id, EditInformation: {},
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 6,
                                                        horizontal: 6),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF9D00).withOpacity(0.75),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      PhosphorIcons
                                                          .pencilSimpleLine(),
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                GestureDetector(
                                                  onTap: () {
                                                    _deleteInformation(
                                                        information.id);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 6,
                                                        horizontal: 6),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF0000).withOpacity(0.75),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
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
                                          image: NetworkImage(
                                            information['image'] ?? '',
                                          ),
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
          ),
        ],
      ),
    );
  }

  void _deleteInformation(String documentId) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Konfirmasi Penghapusan',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus informasi ini?',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Batal',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Hapus',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await DbInformation.deleteInformation(documentId);
      setState(() {});
    }
  }
}
