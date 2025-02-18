import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:essentials/screens/admin/listinformasi_admin_screen.dart';

class UploadPenghasilanOrtuService {
  Future<void> penghasilan_ortu(String id, String selectedDocument, BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/update_ad_penghasilan_ortu.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_penghasilan': id,
          'has_surat_konfirmasi': selectedDocument,
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
          MaterialPageRoute(builder: (context) => ListInformasiAdminScreen()),
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
