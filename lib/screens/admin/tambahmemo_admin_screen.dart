import 'dart:io';
import 'package:essentials/services/create/create_memo_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';

class TambahMemoScreen extends StatefulWidget {
  const TambahMemoScreen({super.key});

  @override
  _TambahMemoScreenState createState() => _TambahMemoScreenState();
}

class _TambahMemoScreenState extends State<TambahMemoScreen> {
  final CreateInfodesService _CreateInfodesService = CreateInfodesService();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  File? selectedImage;

  Future getImage({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImage = File(imagePicked.path);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  Future<void> tambahInformasi() async {
    if (selectedImage == null) {
      _showSnackbar('Foto tidak boleh kosong');
      return;
    }
    if (_judulController.text.isEmpty) {
      _showSnackbar('Judul tidak boleh kosong');
      return;
    }
    if (_isiController.text.isEmpty) {
      _showSnackbar('Isi tidak boleh kosong');
      return;
    }

    await _CreateInfodesService.information_desa(
      _judulController.text,
      _isiController.text,
      File(selectedImage!.path),
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
          'Tambah Memo Desa',
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
                _uploadImage(),
                const SizedBox(height: 12),
                _informasi(),
                const SizedBox(height: 32),
                _uploadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _uploadImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 216,
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
                    selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 212,
                              width: MediaQuery.of(context).size.width,
                              child:
                                  Image.file(selectedImage!, fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImage == null)
                      TextButton(
                        onPressed: () async {
                          await getImage();
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
              if (selectedImage != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = null;
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

  Column _informasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Judul Informasi',
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
              height: 46,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _judulController,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "maksimal 50 karakter ...",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 11),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
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
                  'Isi Informasi',
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
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _isiController,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Isi dengan data yang benar...",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                ),
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
          backgroundColor: const Color(0xFF0D0140),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () {
          tambahInformasi();
        },
        child: Text(
          'Unggah Memo Desa',
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
