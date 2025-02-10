import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/admin/listmemo_desa_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateInfodesService {
  Future<void> information_desa(
      String judul_infodes,
      String isi_infodes,
      String foto_infodes,
      String tgl_upload_infodes,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_information_desa.php';

    String base64Image = '';
    if (foto_infodes.isNotEmpty) {
      try {
        base64Image = base64Encode(File(foto_infodes).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'judul_infodes': judul_infodes,
          'isi_infodes': isi_infodes,
          'foto_infodes': base64Image,
          'tgl_upload_infodes': tgl_upload_infodes,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil membuat Informasi'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MemoDesaAdminScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal membuat Informasi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
