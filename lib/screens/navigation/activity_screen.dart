import 'package:essentials/screens/navigation/activityadministrasi_screen.dart';
import 'package:essentials/screens/navigation/activitypelaporan_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:essentials/screens/navigation/navigation.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _selectedText = 'Riwayat';
  String _selectedOption = 'Semua';

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
                _data(),
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
            const SizedBox(width: 12),
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
                    ? Color(0xff00AA13).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Semua'
                      ? Color(0xff00AA13)
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
                      ? Color(0xff00AA13)
                      : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = 'Administrasi';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Administrasi'
                    ? Color(0xff00AA13).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Administrasi'
                      ? Color(0xff00AA13)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Administrasi',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Administrasi'
                      ? Color(0xff00AA13)
                      : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = 'Pelaporan';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Pelaporan'
                    ? Color(0xff00AA13).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Pelaporan'
                      ? Color(0xff00AA13)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Pelaporan',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Pelaporan'
                      ? Color(0xff00AA13)
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
              MaterialPageRoute(
                  builder: (context) => ActivityPelaporanScreen()),
            );
          },
          child: Container(
            width: double.infinity,
            height: 114,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                    child: Image.asset(
                      'assets/images/test_1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
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
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityAdministrasiScreen()),
            );
          },
          child: Container(
            width: double.infinity,
            height: 84,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Surat Keterangan Tidak Mampu',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Senin, 01 Juli 2024',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
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
      ],
    );
  }
}
