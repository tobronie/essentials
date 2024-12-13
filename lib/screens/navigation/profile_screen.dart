import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/screens/admin/listlaporan_admin_screen.dart';
import 'package:essentials/screens/help/listproblem_screen.dart';
import 'package:essentials/screens/informasi/informasitersimpan_screen.dart';
import 'package:essentials/screens/navigation/desa_screen.dart';
// import 'package:essentials/screens/navigation/detailpengguna_screen.dart';
import 'package:essentials/screens/onboarding_screen.dart';
import 'package:essentials/screens/pejabat/listadministrasi_pejabat_screen.dart';
import 'package:essentials/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:essentials/screens/navigation/navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? selectedImage;
  Future getImage({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (imagePicked != null) {
      selectedImage = File(imagePicked.path);
      setState(() {});
    }
  }

  void muatPreferensiModeGelap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      modeGelap = prefs.getBool('modeGelap') ?? false;
    });
  }

  void simpanPreferensiModeGelap(bool mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('modeGelap', mode);
  }

  void pengubahModeGelap(bool mode) {
    setState(() {
      modeGelap = mode;
    });
    simpanPreferensiModeGelap(mode);
  }

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("User ID: ${user.uid}");
    } else {
      print("No user is currently logged in.");
    }
    muatPreferensiModeGelap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Profile',
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
                _profile(),
                const SizedBox(height: 32),
                _settingAccount(),
                const SizedBox(height: 32),
                _infotmationAccount(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(selectedIndex: 2),
    );
  }

  Widget _profile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/avatar.png',
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff00AA13),
                border: Border.all(color: Color(0xffF9F9F9), width: 2),
              ),
              child: IconButton(
                onPressed: () async {
                  await getImage();
                },
                icon: const Icon(
                  PhosphorIconsRegular.camera,
                  size: 18,
                  color: Color(0xffF9F9F9),
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            constraints: BoxConstraints(maxHeight: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Pengguna Nama Pengguna Nama Pengguna',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 2),
                Text(
                  '1234567890123456',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _settingAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pengaturan Akun',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF616161),
          ),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () async {
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.userCircleCheck,
                  size: 28,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Detail Pengguna',
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
                builder: (context) => ListProblemScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.question,
                  size: 28,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Pusat Bantuan',
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
        // hanya untuk pengguna dan pejabat (mode simpan informasi)
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SaveInformasiScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.bookmarkSimple,
                  size: 28,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Informasi Tersimpan',
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                PhosphorIconsRegular.moon,
                size: 28,
                color: Colors.black,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Mode Gelap',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: modeGelap,
                  onChanged: (value) {
                    setState(() {
                      modeGelap = value;
                      pengubahModeGelap(value);
                    });
                  },
                  activeColor: const Color(0xff00AA13),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Color(0xffD9D9D9),
        ),
      ],
    );
  }

  Widget _infotmationAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Info Lainnya',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF616161),
          ),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DesaKedungmulyoScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
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
                    'Desa Kedungmulyo',
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
        // hanya untuk admin (mode admin)
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListVerifikasiLaporanAdminScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.sealCheck,
                  size: 28,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Verifikasi Admin',
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
        // hanya untuk pejabat desa (mode pejabat)
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListVerifikasiPejabatScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.sealCheck,
                  size: 28,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Verifikasi Pejabat desa',
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
            _logout();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.signOut,
                  size: 28,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Keluar',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF0004),
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
    );
  }

  void _logout() async {
    bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Konfirmasi Keluar',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin keluar dari akun ini?',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xff00AA13),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Iya',
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
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
          (route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal keluar: $e',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                height: 1.2,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      }
    }
  }
}
