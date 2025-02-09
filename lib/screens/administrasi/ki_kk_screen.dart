import 'dart:io';
import 'package:essentials/services/create_ad_kk_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';

class KKScreen extends StatefulWidget {
  const KKScreen({super.key});

  @override
  _KKScreenState createState() => _KKScreenState();
}

class _KKScreenState extends State<KKScreen> {
  final CreateKKService _CreateKKService = CreateKKService();
  final TextEditingController _judulController = TextEditingController();
  File? selectedImageKK;
  File? selectedImageNikahAyah;
  File? selectedImageNikahIbu;
  File? selectedImageIjasahKeluarga;
  File? selectedImageAkteKeluarga;

  Future getImageKK({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageKK = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageNikahAyah({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageNikahAyah = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageNikahIbu({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageNikahIbu = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageIjasahKeluarga({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageIjasahKeluarga = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageAkteKeluarga({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageAkteKeluarga = File(imagePicked.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _judulController.text = "Surat Pengantar Kartu keluarga";
  }

  Future<void> tambahKK() async {
    String FotoKKbefore = selectedImageKK?.path ?? '';

    if (selectedImageNikahAyah == null) {
      _showSnackbar('Foto Buku Nikah Ayah tidak boleh kosong');
      return;
    }

    if (selectedImageNikahIbu == null) {
      _showSnackbar('Foto Buku Nikah Ibu tidak boleh kosong');
      return;
    }

    if (selectedImageIjasahKeluarga == null) {
      _showSnackbar('Foto Ijasah Terakhir Keluarga tidak boleh kosong');
      return;
    }

    if (selectedImageAkteKeluarga == null) {
      _showSnackbar('Foto Akte Keluarga tidak boleh kosong');
      return;
    }

    await _CreateKKService.kk(
      _judulController.text,
      FotoKKbefore,
      selectedImageNikahAyah!.path,
      selectedImageNikahIbu!.path,
      selectedImageIjasahKeluarga!.path,
      selectedImageAkteKeluarga!.path,
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
          'Kartu Keluarga',
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
                _uploadKK(),
                const SizedBox(height: 12),
                _uploadNikahAyah(),
                const SizedBox(height: 12),
                _uploadNikahIbu(),
                const SizedBox(height: 12),
                _uploadIjasahkeluarga(),
                const SizedBox(height: 12),
                _uploadAkteKeluarga(),
                const SizedBox(height: 32),
                _uploadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _uploadKK() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Foto KK Asli/Lama (Opsional)',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
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
                    selectedImageKK != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 74,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(selectedImageKK!,
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImageKK == null)
                      TextButton(
                        onPressed: () async {
                          await getImageKK();
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
              if (selectedImageKK != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageKK = null;
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
    );
  }

  Column _uploadNikahAyah() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foto Buku Nikah Ayah',
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
                    selectedImageNikahAyah != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 74,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(selectedImageNikahAyah!,
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImageNikahAyah == null)
                      TextButton(
                        onPressed: () async {
                          await getImageNikahAyah();
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
              if (selectedImageNikahAyah != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageNikahAyah = null;
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
    );
  }

  Column _uploadNikahIbu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foto Buku Nikah Ibu',
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
                    selectedImageNikahIbu != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 74,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(selectedImageNikahIbu!,
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImageNikahIbu == null)
                      TextButton(
                        onPressed: () async {
                          await getImageNikahIbu();
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
              if (selectedImageNikahIbu != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageNikahIbu = null;
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
    );
  }

  Column _uploadIjasahkeluarga() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foto Ijasah Terakhir Keluarga',
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
                    selectedImageIjasahKeluarga != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 74,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(selectedImageIjasahKeluarga!,
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImageIjasahKeluarga == null)
                      TextButton(
                        onPressed: () async {
                          await getImageIjasahKeluarga();
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
              if (selectedImageIjasahKeluarga != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageIjasahKeluarga = null;
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
        Text(
          'Foto ijasah seluruh keluarga dijadikan satu',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Column _uploadAkteKeluarga() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foto Akte Kelahiran Keluarga',
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
                    selectedImageAkteKeluarga != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 74,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(selectedImageAkteKeluarga!,
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImageAkteKeluarga == null)
                      TextButton(
                        onPressed: () async {
                          await getImageAkteKeluarga();
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
              if (selectedImageAkteKeluarga != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageAkteKeluarga = null;
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
        Text(
          'Foto akte kelahiran seluruh keluarga dijadikan satu',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.2,
            color: Colors.black,
          ),
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
          tambahKK();
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
