import 'dart:io';
import 'package:essentials/services/create/create_ad_kematian_services.dart';
import 'package:essentials/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class KematianScreen extends StatefulWidget {
  const KematianScreen({super.key});

  @override
  _KematianScreenState createState() => _KematianScreenState();
}

class _KematianScreenState extends State<KematianScreen> {
  final CreateKematianService _CreateKematianService = CreateKematianService();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _namaAlmarhumController = TextEditingController();
  final TextEditingController _SKController = TextEditingController();
  File? selectedImageKTPAlmarhum;
  File? selectedImageKK;
  File? selectedImageBukti;
  File? selectedImageKTPSaksi;
  final TextEditingController _konfirmasiController = TextEditingController();

  Future getImageKTPAlmarhum({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageKTPAlmarhum = File(imagePicked.path);
      setState(() {});
    }
  }

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

  Future getImageBukti({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageBukti = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageKTPSaksi({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImageKTPSaksi = File(imagePicked.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userSession = Provider.of<UserSession>(context, listen: false);
      print("User yang login: ${userSession.id_user ?? "Belum Login"}");
    });
    _judulController.text = "Surat Keterangan Kematian";
    _konfirmasiController.text = "menunggu";
    _SKController.text = "";
  }

  Future<void> tambahKematian() async {
    Map<String, File> fileMap = {};

    if (selectedImageKTPAlmarhum != null)
      fileMap['kem_foto_ktp_almarhum'] = selectedImageKTPAlmarhum!;
    if (selectedImageKK != null) fileMap['kem_foto_kk'] = selectedImageKK!;
    if (selectedImageBukti != null) {
      fileMap['kem_foto_bukti'] = selectedImageBukti!;
    } else {
      fileMap['kem_foto_bukti'] = File("");
    }
    if (selectedImageKTPSaksi != null)
      fileMap['kem_foto_ktp_saksi'] = selectedImageKTPSaksi!;

    if (_namaAlmarhumController.text.isEmpty) {
      _showSnackbar('Nama Almarhum tidak boleh kosong');
      return;
    }

    if (selectedImageKTPAlmarhum == null) {
      _showSnackbar('Foto KTP Almarhum tidak boleh kosong');
      return;
    }

    if (selectedImageKK == null) {
      _showSnackbar('Foto KK tidak boleh kosong');
      return;
    }

    if (selectedImageKTPSaksi == null) {
      _showSnackbar('Foto KTP Saksi tidak boleh kosong');
      return;
    }

    await _CreateKematianService.kematian(
      _judulController.text,
      _namaAlmarhumController.text,
      fileMap,
      _SKController.text,
      DateTime.now().toString(),
      _konfirmasiController.text,
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
          'Kematian',
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
                _formulir(),
                const SizedBox(height: 12),
                _uploadKTPAlmarhum(),
                const SizedBox(height: 12),
                _uploadKK(),
                const SizedBox(height: 12),
                _uploadBuktiKematian(),
                const SizedBox(height: 12),
                _uploadKTPSaksi(),
                const SizedBox(height: 32),
                _uploadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _formulir() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Nama Almarhum',
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
              height: 42,
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
                controller: _namaAlmarhumController,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
                decoration: InputDecoration(
                  hintText: "Nama sesuai KTP ...",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 11),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _uploadKTPAlmarhum() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foto KTP Almarhum',
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
                    selectedImageKTPAlmarhum != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 74,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(selectedImageKTPAlmarhum!,
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImageKTPAlmarhum == null)
                      TextButton(
                        onPressed: () async {
                          await getImageKTPAlmarhum();
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
              if (selectedImageKTPAlmarhum != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageKTPAlmarhum = null;
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

  Column _uploadKK() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foto Kartu Keluarga',
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

  Column _uploadKTPSaksi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foto KTP Saksi',
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
                    selectedImageKTPSaksi != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 74,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(selectedImageKTPSaksi!,
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImageKTPSaksi == null)
                      TextButton(
                        onPressed: () async {
                          await getImageKTPSaksi();
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
              if (selectedImageKTPSaksi != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageKTPSaksi = null;
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

  Column _uploadBuktiKematian() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Surat Kematian (Opsional)',
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
                    selectedImageBukti != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 74,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(selectedImageBukti!,
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImageBukti == null)
                      TextButton(
                        onPressed: () async {
                          await getImageBukti();
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
              if (selectedImageBukti != null)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageBukti = null;
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
          'Surat keterangan kematian dari Rumah sakit atau Puskesmas ',
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
          tambahKematian();
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
