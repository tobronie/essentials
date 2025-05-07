import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateSKTMService {
  Future<void> sktm(
      String sktm_judul,
      Map<String, File> fileMap,
      String sktm_nama_wali,
      String sktm_nominal,
      String sktm_rincian,
      String sktm_surat_konfirmasi,
      String sktm_tgl_upload,
      String sktm_konfirmasi,
      BuildContext context) async {
    String url = 'https://essentials.my.id/create_ad_sktm.php';

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
      request.fields['sktm_judul'] = sktm_judul;
      request.fields['sktm_nama_wali'] = sktm_nama_wali;
      request.fields['sktm_nominal'] = sktm_nominal;
      request.fields['sktm_rincian'] = sktm_rincian;
      request.fields['sktm_surat_konfirmasi'] = sktm_surat_konfirmasi;
      request.fields['sktm_tgl_upload'] = sktm_tgl_upload;
      request.fields['sktm_konfirmasi'] = sktm_konfirmasi;

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
