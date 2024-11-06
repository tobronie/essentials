import 'package:essentials/screens/pejabat/pejabat_akte_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_domisili_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_kematian_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_kk_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_ktp_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_nikah_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_penduduk_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_penghasilan_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_sktm_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_tanah_screen.dart';
import 'package:essentials/screens/pejabat/pejabat_usaha_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ListVerifikasiPejabatScreen extends StatefulWidget {
  const ListVerifikasiPejabatScreen({super.key});

  @override
  _ListVerifikasiPejabatScreenState createState() =>
      _ListVerifikasiPejabatScreenState();
}

class _ListVerifikasiPejabatScreenState
    extends State<ListVerifikasiPejabatScreen> {
  String _selectedOption = 'Belum diverifikasi';

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
          'Verifikasi Pejabat desa',
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
                _selectedOption = 'Belum diverifikasi';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Belum diverifikasi'
                    ? Color(0xff00AA13).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Belum diverifikasi'
                      ? Color(0xff00AA13)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Belum diverifikasi',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Belum diverifikasi'
                      ? Color(0xff00AA13)
                      : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = 'Sudah diverifikasi';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedOption == 'Sudah diverifikasi'
                    ? Color(0xff00AA13).withOpacity(0.25)
                    : Colors.white,
                border: Border.all(
                  color: _selectedOption == 'Sudah diverifikasi'
                      ? Color(0xff00AA13)
                      : Color(0xffD9D9D9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Sudah diverifikasi',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _selectedOption == 'Sudah diverifikasi'
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
        //Domisili
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Pejabat_DomisiliScreen()),
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
                          'Nama Pemohon',
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
        const SizedBox(height: 12),
        // SK-Usaha
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_UsahaScreen()),
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
                          'Surat Keterangan Usaha',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Luqman Sandy',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // SK-SKTM
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_SKTMScreen()),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // SK-Kematian
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_KematianScreen()),
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
                          'Surat Keterangan Kematian',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // SK-Penghasilan Orang Tua
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_PenghasilanScreen()),
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
                          'Surat Penghasilan Orang Tua',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // KI-KTP
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_KTPScreen()),
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
                          'Kartu Tanda Penduduk (KTP)',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // KI-KK
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_KKScreen()),
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
                          'Kartu Keluarga (KK)',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // KI-Akte Kelahiran
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_AkteScreen()),
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
                          'Akte Kelahiran',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // KI-Pernikahan
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_NikahScreen()),
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
                          'Pengantar Pernikahan',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // PT-Harga Tanah
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_TanahScreen()),
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
                          'Pengantar Harga Tanah',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
        // KP-Kependudukan
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pejabat_PendudukScreen()),
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
                          'Surat Pindah atau Datang',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          width: 60,
                          color: Color(0xff00AA13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'nama pemohon',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
  }
}
