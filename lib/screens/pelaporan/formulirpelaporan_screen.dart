import 'dart:io';
import 'package:essentials/services/create/create_pelaporan_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PelaporanScreen extends StatefulWidget {
  const PelaporanScreen({super.key});

  @override
  _PelaporanScreenState createState() => _PelaporanScreenState();
}

class _PelaporanScreenState extends State<PelaporanScreen> {
  final CreateLaporService _CreateLaporService = CreateLaporService();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  final TextEditingController _konfirmasiController = TextEditingController();
  DateTime? selectedDateTime;
  File? selectedImage;
  

  Future getImage({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (imagePicked != null) {
      selectedImage = File(imagePicked.path);
      setState(() {});
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    ).then((date) async {
      if (date != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(date),
        );
        if (pickedTime != null) {
          DateTime selected = DateTime(date.year, date.month, date.day,
              pickedTime.hour, pickedTime.minute);
          return selected;
        }
      }
      return null;
    });

    if (pickedDateTime != null) {
      setState(() {
        selectedDateTime = pickedDateTime;
        _waktuController.text =
            DateFormat('dd MMMM yyyy - HH:mm').format(selectedDateTime!);
      });
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _waktuController.dispose();
    _lokasiController.dispose();
    _isiController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  Future<void> tambahPelaporan() async {
    if (selectedImage == null) {
      _showSnackbar('Foto tidak boleh kosong');
      return;
    }

    if (_judulController.text.isEmpty) {
      _showSnackbar(
        'Judul tidak boleh kosong',
      );
      return;
    }

    if (_waktuController.text.isEmpty) {
      _showSnackbar(
        'Waktu tidak boleh kosong',
      );
      return;
    }

    if (_lokasiController.text.isEmpty) {
      _showSnackbar(
        'Lokasi tidak boleh kosong',
      );
      return;
    }

    if (_isiController.text.isEmpty) {
      _showSnackbar(
        'Isi tidak boleh kosong',
      );
      return;
    }

    await _CreateLaporService.pelaporan(
      _judulController.text,
      _waktuController.text,
      _lokasiController.text,
      _isiController.text,
      selectedImage!.path,
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
  void initState() {
    super.initState();
    _konfirmasiController.text = "menunggu";
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
          'Pengaduan',
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
                _formulir(),
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
          height: 152,
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
                              height: 148,
                              width: MediaQuery.of(context).size.width,
                              child:
                                  Image.file(selectedImage!, fit: BoxFit.cover),
                            ),
                          )
                        : Container(),
                    if (selectedImage == null)
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 24),
                                height: 448,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/photo_pelaporan.png',
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    const SizedBox(height: 18),
                                    Column(
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              height: 1.2,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    'Apakah Anda ingin memindai bukti pengaduan menggunakan kamera atau menambahkan foto secara manual',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF00AA13),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await getImage(fromCamera: true);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Pindai Bukti',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF00AA13),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await getImage();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Tambah Manual',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
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
                  'Judul Pengaduan',
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
                controller: _judulController,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "maksimal 40 karakter ...",
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
                  LengthLimitingTextInputFormatter(40),
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
                  'Waktu Kejadian',
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
            GestureDetector(
              onTap: () => _selectDateTime(context),
              child: Container(
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
                child: AbsorbPointer(
                  child: TextField(
                    controller: _waktuController,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: selectedDateTime == null
                          ? "Pilih waktu kejadian ..."
                          : DateFormat('dd/MM/yyyy HH:mm')
                              .format(selectedDateTime!),
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 11),
                    ),
                  ),
                ),
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
                  'Lokasi Kejadian',
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
                controller: _lokasiController,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "maksimal 40 karakter ...",
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
                  LengthLimitingTextInputFormatter(40),
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
                  'Isi Pengaduan',
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
          backgroundColor: const Color(0xFF00AA13),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () {
          tambahPelaporan();
        },
        child: Text(
          'Laporkan Pengaduan',
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
