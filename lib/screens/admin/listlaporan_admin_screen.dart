import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/screens/admin/navigation_admin.dart';
import 'package:essentials/screens/admin/verifikasilaporan_admin_screen.dart';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:essentials/services/pelaporan_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ListVerifikasiLaporanAdminScreen extends StatefulWidget {
  const ListVerifikasiLaporanAdminScreen({super.key});

  @override
  _ListVerifikasiLaporanAdminScreenState createState() =>
      _ListVerifikasiLaporanAdminScreenState();
}

class _ListVerifikasiLaporanAdminScreenState
    extends State<ListVerifikasiLaporanAdminScreen> {
  String _selectedOption = 'Belum diverifikasi';
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
          'Verifikasi Pengaduan',
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
                _option(context),
                const SizedBox(height: 18),
                _data(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AdminCustomNavigationBar(selectedIndex: 0),
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
                    _selectedOption = 'Belum diverifikasi';
                  }
                });
              },
              onTap: () {
                setState(() {
                  _isSearchActive = true;
                  _selectedOption = 'Belum diverifikasi';
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

  Widget _option(BuildContext context) {
    return Container(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryOption('Belum diverifikasi'),
          if (!_isSearchActive) ...[
            _buildCategoryOption('Sudah diverifikasi'),
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
            stream: DbPelaporan.getDataBySearch(_selectedOption, _searchQuery),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot pelaporan = documents[index];
                    String FormatUpload = '';
                    if (pelaporan['tgl_upload'] != null) {
                      Timestamp timestamp = pelaporan['tgl_upload'];
                      DateTime date = timestamp.toDate();
                      FormatUpload = DateFormat('dd MMM yyyy').format(date);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            final String documentId = documents[index].id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DataVerifikasiLaporanScreen(
                                          id: documentId)),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 114,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 98,
                                  height: 98,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      pelaporan['image'] ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pelaporan['judul'] ?? '',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            height: 1.1,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 12),
                                        Container(
                                          height: 2,
                                          width: 60,
                                          color: Color(0xFF0D0140),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          FormatUpload,
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
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
}
