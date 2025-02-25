import 'dart:io';
import 'package:essentials/screens/admin/listmemo_desa_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class CreateInfodesService {
  Future<void> information_desa(
      String judul_infodes,
      String isi_infodes,
      File? foto_infodes,
      String tgl_upload_infodes,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_information_desa.php';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['judul_infodes'] = judul_infodes;
      request.fields['isi_infodes'] = isi_infodes;
      request.fields['tgl_upload_infodes'] = tgl_upload_infodes;

      if (foto_infodes != null && foto_infodes.existsSync()) {
        var mimeType = lookupMimeType(foto_infodes.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'foto_infodes',
            foto_infodes.path,
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
          MaterialPageRoute(builder: (context) => MemoDesaAdminScreen()),
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
