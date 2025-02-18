import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateUsahaService {
  Future<void> usaha(
      String us_judul,
      String us_foto_ktp,
      String us_foto_kk,
      String us_omset,
      String us_tgl_upload,
      String us_konfirmasi,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_usaha.php';

    String base64FotoKTP = '';
    String base64FotoKK = '';
    if (us_foto_ktp.isNotEmpty) {
      try {
        base64FotoKTP = base64Encode(File(us_foto_ktp).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar ktp: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (us_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(us_foto_kk).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar ktp: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'us_judul': us_judul,
          'us_foto_ktp': base64FotoKTP,
          'us_foto_kk': base64FotoKK,
          'us_omset': us_omset,
          'us_tgl_upload': us_tgl_upload,
          'us_konfirmasi': us_konfirmasi,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
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
            content: Text(data['message'] ?? 'Gagal Pengajuan Surat'),
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
