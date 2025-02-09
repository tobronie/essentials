import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:essentials/screens/admin/listinformasi_admin_screen.dart';

class CreateInfoService {
  Future<void> information(
      String judul_info,
      String kategori_info,
      String isi_info,
      String foto_info,
      String tgl_upload_info,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_information.php';

    String base64Image = '';
    if (foto_info.isNotEmpty) {
      try {
        base64Image = base64Encode(File(foto_info).readAsBytesSync());
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
          'judul_info': judul_info,
          'kategori_info': kategori_info,
          'isi_info': isi_info,
          'foto_info': base64Image,
          'tgl_upload_info': tgl_upload_info,
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
          MaterialPageRoute(builder: (context) => ListInformasiAdminScreen()),
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
