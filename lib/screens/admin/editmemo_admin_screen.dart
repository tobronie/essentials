import 'dart:convert';
import 'package:essentials/services/update/update_information_desa_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class EditInformasiDesaScreen extends StatefulWidget {
  final String id_infodes;
  const EditInformasiDesaScreen({super.key, required this.id_infodes});

  @override
  _EditInformasiDesaScreenState createState() => _EditInformasiDesaScreenState();
}

class _EditInformasiDesaScreenState extends State<EditInformasiDesaScreen> {
  final UpdateMemoService _UpdateMemoService = UpdateMemoService();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  late Future<List<dynamic>> _futureInformationDesa;

  @override
  void initState() {
    super.initState();
    _futureInformationDesa = getInformationDesa();
  }

  Future<List<dynamic>> getInformationDesa() async {
    String url =
        'https://essentials.my.id/get_information_desa.php?id_infodes=${widget.id_infodes}';
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            if (_judulController.text.isEmpty) {
              _judulController.text = data[0]['judul_infodes'];
            }
            if (_isiController.text.isEmpty) {
              _isiController.text = data[0]['isi_infodes'];
            }
          });
          return data;
        }
      }
      throw Exception('Gagal mengambil data');
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<void> editInformasiDesa() async {
    if (_judulController.text.isEmpty) {
      _showSnackbar('Judul tidak boleh kosong');
      return;
    }
    if (_judulController.text.length > 50) {
      _showSnackbar('Judul maksimal 50 karakter');
      return;
    }
    if (_isiController.text.isEmpty) {
      _showSnackbar('Isi tidak boleh kosong');
      return;
    }

    await _UpdateMemoService.memo(
      widget.id_infodes,
      _judulController.text,
      _isiController.text,
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
          'Edit Memo Desa',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F9F9),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureInformationDesa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text("Data tidak ditemukan atau kosong"));
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            var information = snapshot.data![0];
            if (_judulController.text.isEmpty && _isiController.text.isEmpty) {
              _judulController.text = information['judul_infodes'];
              _isiController.text = information['isi_infodes'];
            }
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _InformasiDesa(),
                  const SizedBox(height: 32),
                  _uploadButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column _InformasiDesa() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Judul Memo Desa',
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
                controller: _judulController,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Maksimal 50 karakter ...",
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
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Isi Memo Desa',
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 11),
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
          editInformasiDesa();
        },
        child: Text(
          'Perbarui Memo Desa',
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
