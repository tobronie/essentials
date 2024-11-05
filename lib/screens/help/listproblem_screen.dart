import 'package:essentials/screens/help/application_screen.dart';
import 'package:essentials/screens/help/problemakun_screen.dart';
import 'package:essentials/screens/help/problemadministrasi_screen.dart';
import 'package:essentials/screens/help/probleminformasi_screen.dart';
import 'package:essentials/screens/help/problempelaporan_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ListProblemScreen extends StatefulWidget {
  const ListProblemScreen({super.key});

  @override
  _ListProblemScreenState createState() => _ListProblemScreenState();
}

class _ListProblemScreenState extends State<ListProblemScreen> {
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
          'Bantuan',
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cari masalah yang anda alami',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF616161),
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProblemAkunScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsRegular.userCircle,
                          size: 28,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Masalah pada akun',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          PhosphorIconsRegular.caretRight,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xffD9D9D9),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProblemAdministrasiScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsRegular.fileText,
                          size: 28,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Masalah fitur administrasi',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          PhosphorIconsRegular.caretRight,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xffD9D9D9),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProblemPelaporanScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsRegular.files,
                          size: 28,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Masalah fitur pelaporan',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          PhosphorIconsRegular.caretRight,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xffD9D9D9),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProblemInformasiScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsRegular.fileMagnifyingGlass,
                          size: 28,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Masalah fitur informasi',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          PhosphorIconsRegular.caretRight,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xffD9D9D9),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationEssentialsScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsRegular.info,
                          size: 28,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Tentang aplikasi essentials',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          PhosphorIconsRegular.caretRight,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xffD9D9D9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
