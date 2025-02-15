import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:essentials/screens/admin/listinformasi_admin_screen.dart';

class UpdateInfoService {
  Future<void> information(String id_info, String judul_info, String kategori_info,
      String isi_info, String tgl_upload_info, BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/update_information.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_info': id_info,
          'judul_info': judul_info,
          'kategori_info': kategori_info,
          'isi_info': isi_info,
          'tgl_upload_info': tgl_upload_info,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil memperbarui Informasi'),
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
            content: Text(data['message'] ?? 'Gagal memperbarui Informasi'),
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
