import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateSKTMService {
  Future<void> sktm(
      String sktm_judul,
      String sktm_foto_ktp,
      String sktm_foto_kk,
      String sktm_nama_wali,
      String sktm_nominal,
      String sktm_rincian,
      String sktm_tgl_upload,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_sktm.php';

    String base64FotoKTP = '';
    String base64FotoKK = '';
    
    if (sktm_foto_ktp.isNotEmpty) {
      try {
        base64FotoKTP = base64Encode(File(sktm_foto_ktp).readAsBytesSync());
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

    if (sktm_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(sktm_foto_kk).readAsBytesSync());
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
          'sktm_judul': sktm_judul,
          'sktm_foto_ktp': base64FotoKTP,
          'sktm_foto_kk': base64FotoKK,
          'sktm_nama_wali': sktm_nama_wali,
          'sktm_nominal': sktm_nominal,
          'sktm_rincian': sktm_rincian,
          'sktm_tgl_upload': sktm_tgl_upload,
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
