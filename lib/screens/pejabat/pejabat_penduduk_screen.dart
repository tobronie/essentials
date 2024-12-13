import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/screens/pejabat/listadministrasi_pejabat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';

class Pejabat_PendudukScreen extends StatefulWidget {
  final String id;
  const Pejabat_PendudukScreen({Key? key, required this.id}) : super(key: key);

  @override
  _Pejabat_PendudukScreenState createState() => _Pejabat_PendudukScreenState();
}

class _Pejabat_PendudukScreenState extends State<Pejabat_PendudukScreen> {
  bool _isImageVisibleKTP = false;
  bool _isImageVisibleKK = false;
  bool _isImageVisibleNikahAyah = false;
  bool _isImageVisibleNikahIbu = false;
  Map<String, dynamic>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("User ID: ${user.uid}");
    } else {
      print("No user is currently logged in.");
    }
    fetchData();
  }

  void fetchData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('pendudukan')
          .doc(widget.id)
          .get();

      if (snapshot.exists) {
        setState(() {
          data = snapshot.data() as Map<String, dynamic>?;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
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
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Verifikasi Kependudukan',
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : data == null
                ? const Center(child: Text('Data tidak ditemukan'))
                : Container(
                    color: const Color(0xffF9F9F9),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _dataPengajuan(),
                          const SizedBox(height: 8),
                          _imageKTP(),
                          const SizedBox(height: 12),
                          _imageKK(),
                          const SizedBox(height: 12),
                          _imagenikahAyah(),
                          const SizedBox(height: 12),
                          _imageNikahIbu(),
                          const SizedBox(height: 12),
                          _daerahAsal(),
                          const SizedBox(height: 12),
                          _daerahTujuan(),
                          const SizedBox(height: 24),
                          const Divider(
                            color: Color(0xffD9D9D9),
                          ),
                          const SizedBox(height: 24),
                          _dataAkun(),
                          const SizedBox(height: 42),
                          _konfirmasi(),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Column _dataPengajuan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Pengajuan:',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _imageKTP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto KTP Pemohon',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 2, left: 8, top: 8, bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.file(),
                            color: Colors.black.withOpacity(0.7),
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data?['foto_ktp'] ?? '',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isImageVisibleKTP
                          ? PhosphorIcons.eye()
                          : PhosphorIcons.eyeSlash(),
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isImageVisibleKTP = !_isImageVisibleKTP;
                      });
                      _showDialogFotoKTP(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _imageKK() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto Kartu Keluarga',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 2, left: 8, top: 8, bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.file(),
                            color: Colors.black.withOpacity(0.7),
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data?['foto_kk'] ?? '',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isImageVisibleKK
                          ? PhosphorIcons.eye()
                          : PhosphorIcons.eyeSlash(),
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isImageVisibleKK = !_isImageVisibleKK;
                      });
                      _showDialogFotoKK(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _imagenikahAyah() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto Buku Nikah Pria',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: data?['foto_nikah_ayah'] != null &&
                      data!['foto_nikah_ayah'].isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 2, left: 8, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Icon(
                                  PhosphorIcons.file(),
                                  color: Colors.black.withOpacity(0.7),
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    data?['foto_nikah_ayah'] ?? '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isImageVisibleNikahAyah
                                ? PhosphorIcons.eye()
                                : PhosphorIcons.eyeSlash(),
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isImageVisibleNikahAyah =
                                  !_isImageVisibleNikahAyah;
                            });
                            _showDialogFotoNikahAyah(context);
                          },
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Foto tidak tersedia",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red.withOpacity(0.8),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Column _imageNikahIbu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto Buku Nikah Wanita',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: data?['foto_nikah_ibu'] != null &&
                      data!['foto_nikah_ibu'].isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 2, left: 8, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Icon(
                                  PhosphorIcons.file(),
                                  color: Colors.black.withOpacity(0.7),
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    data?['foto_nikah_ibu'] ?? '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isImageVisibleNikahIbu
                                ? PhosphorIcons.eye()
                                : PhosphorIcons.eyeSlash(),
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isImageVisibleNikahIbu =
                                  !_isImageVisibleNikahIbu;
                            });
                            _showDialogFotoNikahIbu(context);
                          },
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Foto tidak tersedia",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red.withOpacity(0.8),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Column _daerahAsal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daerah Asal Tinggal',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data?['daerah_asal'] ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _daerahTujuan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daerah Tujuan Tinggal',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data?['daerah_tujuan'] ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _dataAkun() {
    String FormatUpload = '';
    if (data != null && data!['tgl_upload'] != null) {
      Timestamp timestamp = data!['tgl_upload'];
      DateTime date = timestamp.toDate();
      FormatUpload = DateFormat('dd MMMM yyyy - HH:mm').format(date);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Akun:',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Pemohon',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data?['nama'] ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Handphone',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data?['no_hp'] ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data?['email'] ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waktu Pengajuan',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 42,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                FormatUpload,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showDialogFotoKTP(BuildContext context) {
    if (_isImageVisibleKTP) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            backgroundColor: Colors.transparent,
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 5.0,
              child: Image.network(
                data?['foto_ktp'] ?? '',
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ).then((_) {
        setState(() {
          _isImageVisibleKTP = false;
        });
      });
    }
  }

  void _showDialogFotoKK(BuildContext context) {
    if (_isImageVisibleKK) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            backgroundColor: Colors.transparent,
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 5.0,
              child: Image.network(
                data?['foto_kk'] ?? '',
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ).then((_) {
        setState(() {
          _isImageVisibleKK = false;
        });
      });
    }
  }

  void _showDialogFotoNikahAyah(BuildContext context) {
    if (_isImageVisibleNikahAyah) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            backgroundColor: Colors.transparent,
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 5.0,
              child: Image.network(
                data?['foto_nikah_ayah'] ?? '',
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ).then((_) {
        setState(() {
          _isImageVisibleNikahAyah = false;
        });
      });
    }
  }

  void _showDialogFotoNikahIbu(BuildContext context) {
    if (_isImageVisibleNikahIbu) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            backgroundColor: Colors.transparent,
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 5.0,
              child: Image.network(
                data?['foto_nikah_ibu'] ?? '',
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ).then((_) {
        setState(() {
          _isImageVisibleNikahIbu = false;
        });
      });
    }
  }

  Row _konfirmasi() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF0004),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListVerifikasiPejabatScreen()),
                );
              },
              child: Text(
                'Tidak Disetujui',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff00AA13),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListVerifikasiPejabatScreen()),
                );
              },
              child: Text(
                'Setuju',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
