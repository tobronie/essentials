import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateDomisiliService {
  Future<void> domisili(
      String dom_judul,
      String dom_foto_ktp,
      String dom_foto_kk,
      String dom_surat_konfirmasi,
      String dom_tgl_upload,
      String dom_konfirmasi,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_domisili.php';

    String base64FotoKTP = '';
    String base64FotoKK = '';
    if (dom_foto_ktp.isNotEmpty) {
      try {
        base64FotoKTP = base64Encode(File(dom_foto_ktp).readAsBytesSync());
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

    if (dom_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(dom_foto_kk).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar kk: $e'),
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
          'dom_judul': dom_judul,
          'dom_foto_ktp': base64FotoKTP,
          'dom_foto_kk': base64FotoKK,
          'dom_surat_konfirmasi': dom_surat_konfirmasi,
          'dom_tgl_upload': dom_tgl_upload,
          'dom_konfirmasi': dom_konfirmasi,
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
