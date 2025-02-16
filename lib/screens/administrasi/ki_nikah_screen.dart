import 'dart:io';
import 'package:essentials/services/create/create_ad_nikah_services.dart';
import 'package:essentials/services/download_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';

class NikahScreen extends StatefulWidget {
  const NikahScreen({super.key});

  @override
  _NikahScreenState createState() => _NikahScreenState();
}

class _NikahScreenState extends State<NikahScreen> {
  final CreateNikahService _CreateNikahService = CreateNikahService();
  final TextEditingController _judulController = TextEditingController();
  File? selectedImageKTPPria;
  File? selectedImageKTPWanita;
  File? selectedImageKKPria;
  File? selectedImageKKWanita;
  File? selectedImageFormulirPria;
  File? selectedImageFormulirWanita;
  File? selectedImageAktePria;
  File? selectedImageAkteWanita;
  File? selectedImageNikahAyahPria;
  File? selectedImageNikahAyahWanita;
  File? selectedImageNikahIbuPria;
  File? selectedImageNikahIbuWanita;
  var statusDownload = "";

  Future getImageKTPPria({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageKTPPria = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageKTPWanita({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageKTPWanita = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageKKPria({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageKKPria = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageKKWanita({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageKKWanita = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageAkteWanita({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageAkteWanita = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageAktePria({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageAktePria = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageNikahAyahWanita({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageNikahAyahWanita = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageNikahAyahPria({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageNikahAyahPria = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageNikahIbuWanita({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageNikahIbuWanita = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageNikahIbuPria({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageNikahIbuPria = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageFormulirPria({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageFormulirPria = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageFormulirWanita({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageFormulirWanita = File(imagePicked.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _judulController.text = "Surat Pengantar Pernikahan";
  }

  Future<void> tambahNikah() async {
    if (selectedImageKTPPria == null) {
      _showSnackbar('Foto KTP Pria tidak boleh kosong');
      return;
    }

    if (selectedImageAktePria == null) {
      _showSnackbar('Foto Akte Kelahiran Pria tidak boleh kosong');
      return;
    }

    if (selectedImageKKPria == null) {
      _showSnackbar('Foto Kartu Keluarga Pria tidak boleh kosong');
      return;
    }

    if (selectedImageNikahAyahPria == null) {
      _showSnackbar('Foto Buku Nikah Ayah Pria tidak boleh kosong');
      return;
    }

    if (selectedImageNikahIbuPria == null) {
      _showSnackbar('Foto Buku Nikah Ibu Pria tidak boleh kosong');
      return;
    }

    if (selectedImageFormulirPria == null) {
      _showSnackbar('Foto Formulir Pria tidak boleh kosong');
      return;
    }

    if (selectedImageKTPWanita == null) {
      _showSnackbar('Foto KTP Wanita tidak boleh kosong');
      return;
    }

    if (selectedImageAkteWanita == null) {
      _showSnackbar('Foto Akte Kelahiran Wanita tidak boleh kosong');
      return;
    }

    if (selectedImageKKWanita == null) {
      _showSnackbar('Foto Kartu Keluarga Wanita tidak boleh kosong');
      return;
    }

    if (selectedImageNikahAyahWanita == null) {
      _showSnackbar('Foto Buku Nikah Ayah Wanita tidak boleh kosong');
      return;
    }

    if (selectedImageNikahIbuWanita == null) {
      _showSnackbar('Foto Buku Nikah Ibu Wanita tidak boleh kosong');
      return;
    }

    if (selectedImageFormulirWanita == null) {
      _showSnackbar('Foto Formulir Wanita tidak boleh kosong');
      return;
    }

    await _CreateNikahService.nikah(
      _judulController.text,
      selectedImageKTPPria!.path,
      selectedImageKKPria!.path,
      selectedImageAktePria!.path,
      selectedImageFormulirPria!.path,
      selectedImageNikahAyahPria!.path,
      selectedImageNikahIbuPria!.path,
      selectedImageKTPWanita!.path,
      selectedImageKKWanita!.path,
      selectedImageAkteWanita!.path,
      selectedImageFormulirWanita!.path,
      selectedImageNikahAyahWanita!.path,
      selectedImageNikahIbuWanita!.path,
      DateTime.now().toString(),
      context,
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            height: 1.2,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Pernikahan',
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
        child: Container(
          color: const Color(0xffF9F9F9),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _formulirPria(),
                const SizedBox(height: 12),
                _formulirWanita(),
                const SizedBox(height: 32),
                _uploadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _formulirPria() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biodata Calon Mempelai Pria:',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto KTP',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageKTPPria != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageKTPPria!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageKTPPria == null)
                          TextButton(
                            onPressed: () async {
                              await getImageKTPPria();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageKTPPria != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageKTPPria = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Akte Kelahiran ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageAktePria != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageAktePria!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageAktePria == null)
                          TextButton(
                            onPressed: () async {
                              await getImageAktePria();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageAktePria != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageAktePria = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Kartu Keluarga ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageKKPria != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageKKPria!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageKKPria == null)
                          TextButton(
                            onPressed: () async {
                              await getImageKKPria();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageKKPria != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageKKPria = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Buku Nikah Ayah ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageNikahAyahPria != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageNikahAyahPria!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageNikahAyahPria == null)
                          TextButton(
                            onPressed: () async {
                              await getImageNikahAyahPria();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageNikahAyahPria != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageNikahAyahPria = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Buku Nikah Ibu ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageNikahIbuPria != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageNikahIbuPria!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageNikahIbuPria == null)
                          TextButton(
                            onPressed: () async {
                              await getImageNikahIbuPria();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageNikahIbuPria != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageNikahIbuPria = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Formulir Calon Pria',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageFormulirPria != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageFormulirPria!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageFormulirPria == null)
                          TextButton(
                            onPressed: () async {
                              await getImageFormulirPria();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageFormulirPria != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageFormulirPria = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(
                    text: 'Unduh ',
                  ),
                  TextSpan(
                    text: 'Formulir Pernikahan',
                    style: const TextStyle(
                      color: Color(0xFF5E28FF),
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        var downloadService = DownloadServices();
                        await downloadService.downloadNikah(context);
                      },
                  ),
                  const TextSpan(
                      text: ', isi, kemudian foto dan unggah kembali'),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const Divider(
              color: Color(0xffD9D9D9),
            ),
          ],
        ),
      ],
    );
  }

  Column _formulirWanita() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biodata Calon Mempelai Wanita:',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto KTP',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageKTPWanita != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageKTPWanita!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageKTPWanita == null)
                          TextButton(
                            onPressed: () async {
                              await getImageKTPWanita();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageKTPWanita != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageKTPWanita = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Akte Kelahiran ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageAkteWanita != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageAkteWanita!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageAkteWanita == null)
                          TextButton(
                            onPressed: () async {
                              await getImageAkteWanita();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageAkteWanita != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageAkteWanita = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Kartu Keluarga ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageKKWanita != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(selectedImageKKWanita!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageKKWanita == null)
                          TextButton(
                            onPressed: () async {
                              await getImageKKWanita();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageKKWanita != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageKKWanita = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Buku Nikah Ayah ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageNikahAyahWanita != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                      selectedImageNikahAyahWanita!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageNikahAyahWanita == null)
                          TextButton(
                            onPressed: () async {
                              await getImageNikahAyahWanita();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageNikahAyahWanita != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageNikahAyahWanita = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Buku Nikah Ibu ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageNikahIbuWanita != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                      selectedImageNikahIbuWanita!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageNikahIbuWanita == null)
                          TextButton(
                            onPressed: () async {
                              await getImageNikahIbuWanita();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageNikahIbuWanita != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageNikahIbuWanita = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Foto Formulir Calon Wanita',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedImageFormulirWanita != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 74,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                      selectedImageFormulirWanita!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(),
                        if (selectedImageFormulirWanita == null)
                          TextButton(
                            onPressed: () async {
                              await getImageFormulirWanita();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  PhosphorIconsRegular.fileArrowUp,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Unggah foto disini',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedImageFormulirWanita != null)
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageFormulirWanita = null;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: const Icon(
                                PhosphorIconsRegular.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(
                    text: 'Unduh ',
                  ),
                  TextSpan(
                    text: 'Formulir Pernikahan',
                    style: const TextStyle(
                      color: Color(0xFF5E28FF),
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        var downloadService = DownloadServices();
                        await downloadService.downloadNikah(context);
                      },
                  ),
                  const TextSpan(
                      text: ', isi, kemudian foto dan unggah kembali'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _uploadButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00AA13),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () {
          tambahNikah();
        },
        child: Text(
          'Unggah Formulir',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
