import 'dart:convert';
import 'package:essentials/screens/admin/listmemo_desa_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateMemoService {
  Future<void> memo(
      String id_infodes,
      String judul_infodes,
      String isi_infodes,
      String tgl_upload_infodes,
      BuildContext context) async {
    String url =
        'http://10.0.2.2:8080/essentials_api/update_information_desa.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_infodes': id_infodes,
          'judul_infodes': judul_infodes,
          'isi_infodes': isi_infodes,
          'tgl_upload_infodes': tgl_upload_infodes,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil memperbarui Memo Desa'),
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
            content: Text(data['message'] ?? 'Gagal memperbarui Memo Desa'),
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
