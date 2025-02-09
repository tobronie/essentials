import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateKTPService {
  Future<void> ktp(
      String kt_judul,
      String? kt_foto_akte,
      String kt_foto_kk,
      String kt_foto_formulir,
      String kt_tgl_upload,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_ktp.php';

    String base64FotoAkte = '';
    String base64FotoKK = '';
    String base64FotoFormulir = '';

    if (kt_foto_akte?.isNotEmpty ?? false) {
      try {
        base64FotoAkte = base64Encode(File(kt_foto_akte!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Akte: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (kt_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(kt_foto_kk).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Kartu Keluarga: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (kt_foto_formulir.isNotEmpty) {
      try {
        base64FotoFormulir = base64Encode(File(kt_foto_formulir).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Surat Persetujuan Orang Tua: $e'),
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
          'kt_judul': kt_judul,
          'kt_foto_akte': base64FotoAkte.isNotEmpty ? base64FotoAkte : '',
          'kt_foto_kk': base64FotoKK,
          'kt_foto_formulir': base64FotoFormulir,
          'kt_tgl_upload': kt_tgl_upload,
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
