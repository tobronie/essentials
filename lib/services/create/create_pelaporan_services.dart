import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class CreateLaporService {
  Future<void> pelaporan(
      String judul_lapor,
      String waktu_lapor,
      String lokasi_lapor,
      String isi_lapor,
      File? foto_lapor,
      String tgl_upload_lapor,
      String konfirmasi_lapor,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_pelaporan.php';

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
      request.fields['judul_lapor'] = judul_lapor;
      request.fields['waktu_lapor'] = waktu_lapor;
      request.fields['lokasi_lapor'] = lokasi_lapor;
      request.fields['isi_lapor'] = isi_lapor;
      request.fields['tgl_upload_lapor'] = tgl_upload_lapor;
      request.fields['konfirmasi_lapor'] = konfirmasi_lapor;

      if (foto_lapor != null && foto_lapor.existsSync()) {
        var mimeType = lookupMimeType(foto_lapor.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'foto_lapor',
            foto_lapor.path,
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
            content: Text('Berhasil membuat Pengaduan'),
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
            content: Text('Gagal membuat Pengaduan: $responseData'),
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
