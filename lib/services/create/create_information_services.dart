import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:essentials/screens/admin/listinformasi_admin_screen.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class CreateInfoService {
  Future<void> information(
      String judul_info,
      String kategori_info,
      String isi_info,
      File? foto_info,
      String tgl_upload_info,
      BuildContext context) async {
    String url = 'https://essentials.my.id/create_information.php';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['judul_info'] = judul_info;
      request.fields['kategori_info'] = kategori_info;
      request.fields['isi_info'] = isi_info;
      request.fields['tgl_upload_info'] = tgl_upload_info;

      if (foto_info != null && foto_info.existsSync()) {
        var mimeType = lookupMimeType(foto_info.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'foto_info',
            foto_info.path,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print("Response Data: $responseData");

      if (response.statusCode == 200) {
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
            content: Text('Gagal membuat Informasi: $responseData'),
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