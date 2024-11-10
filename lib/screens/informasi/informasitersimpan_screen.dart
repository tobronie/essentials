import 'package:essentials/screens/informasi/detailinformasi_screen.dart';
import 'package:essentials/services/information_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SaveInformasiScreen extends StatefulWidget {
  const SaveInformasiScreen({super.key});

  @override
  _SaveInformasiScreenState createState() => _SaveInformasiScreenState();
}

class _SaveInformasiScreenState extends State<SaveInformasiScreen> {
  String _selectedOption = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
                _option(context),
                const SizedBox(height: 18),
                _data(),
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
                _selectedOption = 'Infrastruktur';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Infrastruktur'
                    ? Color(0xff00AA13).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Infrastruktur'
                      ? Color(0xff00AA13)
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
                      ? Color(0xff00AA13)
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
                    ? Color(0xff00AA13).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Kecelakaan'
                      ? Color(0xff00AA13)
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
                      ? Color(0xff00AA13)
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
                    ? Color(0xff00AA13).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Kegiatan'
                      ? Color(0xff00AA13)
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
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => InformasiDetailScreen(
          //         information:
          //             information.data() as Map<String, dynamic>,
          //       ),
          //     ),
          //   );
          // },
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
                          image: AssetImage('assets/images/test_1.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.bookmark_rounded,
                      size: 32,
                      color: Color(0xff00AA13),
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
