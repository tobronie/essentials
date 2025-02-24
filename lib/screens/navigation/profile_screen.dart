import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/detailpengguna_screen.dart';
import 'package:http/http.dart' as http;
import 'package:essentials/screens/admin/listlaporan_admin_screen.dart';
import 'package:essentials/screens/admin/listmemo_desa_admin_screen.dart';
import 'package:essentials/screens/help/listproblem_screen.dart';
import 'package:essentials/screens/informasi/informasitersimpan_screen.dart';
import 'package:essentials/screens/navigation/desa_screen.dart';
import 'package:essentials/screens/onboarding_screen.dart';
import 'package:essentials/screens/pejabat/listadministrasi_pejabat_screen.dart';
import 'package:essentials/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:essentials/screens/navigation/navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userSession = Provider.of<UserSession>(context, listen: false);
      print("User yang login: ${userSession.id_user ?? "Belum Login"}");
    });
    super.initState();
  }

  Future<Map<String, dynamic>?> getUser(String id_user) async {
    String url =
        'http://10.0.2.2:8080/essentials_api/get_user.php?id_user=$id_user';

    try {
      var response = await http.get(Uri.parse(url));
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Parsed Data: $data");

        if (data is List && data.isNotEmpty) {
          return data[0];
        } else if (data is Map<String, dynamic>) {
          return data;
        } else {
          throw Exception("Format data tidak valid");
        }
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<UserSession>(context, listen: false);

    return FutureBuilder<Map<String, dynamic>?>(
      future: getUser(userSession.id_user ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            body: Center(child: Text("Pengguna Tidak Ditemukan")),
          );
        }
        print(userSession.id_user);
        String userName = snapshot.data?["nama"]?.toString() ?? "Nama Pengguna";
        String userNIK = snapshot.data?["nik"]?.toString() ?? "NIK Pengguna";
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
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _profile(userName, userNIK),
                    const SizedBox(height: 22),
                    _settingAccount(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomNavigationBar(selectedIndex: 2),
        );
      },
    );
  }

  Widget _profile(String nama, nik) {
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
                  nama,
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
                  nik,
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
          'Info Akun',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF616161),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPenggunaScreen()),
            );
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
        // hanya untuk admin (memo desa)
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemoDesaAdminScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.note,
                  size: 28,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Memo Desa',
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
            print("Logout button tapped");
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
    print("Logout function triggered");

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
        print("User confirmed logout");
        await Provider.of<UserSession>(context, listen: false).logout();
        print("User session cleared");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
          (route) => false,
        );

        print("Navigated to Onboarding Screen");
      } catch (e) {
        print("Logout error: $e");
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
    } else {
      print("User cancelled logout");
    }
  }
}
