import 'package:essentials/screens/admin/navigation_admin.dart';
import 'package:essentials/screens/admin/tambahinformasi_admin_screen.dart';
import 'package:essentials/screens/informasi/detailinformasi_screen.dart';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ListInformasiAdminScreen extends StatefulWidget {
  const ListInformasiAdminScreen({super.key});

  @override
  _ListInformasiAdminScreenState createState() =>
      _ListInformasiAdminScreenState();
}

class _ListInformasiAdminScreenState extends State<ListInformasiAdminScreen> {
  String _selectedOption = 'Semua';

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
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
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
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = 'Semua';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Semua'
                    ? Color(0xFF0D0140).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Semua'
                      ? Color(0xFF0D0140)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Semua',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Semua'
                      ? Color(0xFF0D0140)
                      : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = 'Infrastruktur';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Infrastruktur'
                    ? Color(0xFF0D0140).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Infrastruktur'
                      ? Color(0xFF0D0140)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Infrastruktur',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Infrastruktur'
                      ? Color(0xFF0D0140)
                      : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = 'Kecelakaan';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Kecelakaan'
                    ? Color(0xFF0D0140).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Kecelakaan'
                      ? Color(0xFF0D0140)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Kecelakaan',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Kecelakaan'
                      ? Color(0xFF0D0140)
                      : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = 'Kegiatan';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Kegiatan'
                    ? Color(0xFF0D0140).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Kegiatan'
                      ? Color(0xFF0D0140)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Kegiatan',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Kegiatan'
                      ? Color(0xFF0D0140)
                      : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = 'Sosial';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Sosial'
                    ? Color(0xFF0D0140).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Sosial'
                      ? Color(0xFF0D0140)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Sosial',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Sosial'
                      ? Color(0xFF0D0140)
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _data() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformasiDetailScreen()),
            );
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
                          'Kerusakan Got di JL. Kalikening barat samping warung',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Senin, 01 Juli 2024',
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/template.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        PhosphorIconsRegular.trash,
                        size: 36,
                        color: Color(0xFFFF0004),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Color(0xffD9D9D9),
        ),
      ],
    );
  }
}
