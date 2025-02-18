import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:essentials/screens/admin/listadministrasi_admin_screen.dart';

class UploadTanahService {
  Future<void> tanah(String id, String selectedDocument, BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/update_ad_tanah.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_tanah' : id,
          'tan_surat_konfirmasi': selectedDocument,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil mengupload Surat Konfirmasi'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListVerifikasiAdministrasiAdminScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal mengupload Surat Konfirmasi'),
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
