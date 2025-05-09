import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNikahService {
  Future<void> nikah(
      String ni_judul,
      Map<String, File> fileMap,
      String ni_surat_konfirmasi,
      String ni_tgl_upload,
      String ni_konfirmasi,
      BuildContext context) async {
    String url = 'https://essentials.my.id/create_ad_nikah.php';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_user = prefs.getString('id_user');

    if (id_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengirim laporan: User tidak ditemukan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id_user'] = id_user;
      request.fields['ni_judul'] = ni_judul;
      request.fields['ni_surat_konfirmasi'] = ni_surat_konfirmasi;
      request.fields['ni_tgl_upload'] = ni_tgl_upload;
      request.fields['ni_konfirmasi'] = ni_konfirmasi;

      for (var entry in fileMap.entries) {
        if (entry.value.existsSync()) {
          var mimeType = lookupMimeType(entry.value.path);
          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              entry.value.path,
              contentType: mimeType != null ? MediaType.parse(mimeType) : null,
            ),
          );
        }
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print("Response Status Code: ${response.statusCode}");
      print("Response Data: $responseData");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil Pengajuan Surat'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ActivityScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal Pengajuan Surat: $responseData'),
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
