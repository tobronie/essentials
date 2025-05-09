import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/admin/listadministrasi_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UploadKKService {
  Future<void> kk(String id, File selectedDocument, BuildContext context) async {
    String url = 'https://essentials.my.id/update_ad_kk.php';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id_kk'] = id;
      request.files.add(
        await http.MultipartFile.fromPath(
          'kk_surat_konfirmasi',
          selectedDocument.path,
          contentType: MediaType('application', 'pdf'),
        ),
      );

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var data = jsonDecode(responseData);

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
          const SnackBar(
            content: Text('Gagal mengupload Surat Konfirmasi'),
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
