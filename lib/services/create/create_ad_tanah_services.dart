import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateTanahService {
  Future<void> tanah(
      String tan_judul,
      String tan_foto_ktp,
      String tan_foto_kk,
      String tan_foto_sppt_shm,
      String tan_surat_konfirmasi,
      String tan_tgl_upload,
      String tan_konfirmasi,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_tanah.php';

    String base64FotoKTP = '';
    String base64FotoKK = '';
    String base64FotoSPPT_SHM = '';

    if (tan_foto_ktp.isNotEmpty) {
      try {
        base64FotoKTP = base64Encode(File(tan_foto_ktp).readAsBytesSync());
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

    if (tan_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(tan_foto_kk).readAsBytesSync());
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

    if (tan_foto_sppt_shm.isNotEmpty) {
      try {
        base64FotoSPPT_SHM = base64Encode(File(tan_foto_sppt_shm).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar SPPT dan SHM: $e'),
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
          'tan_judul': tan_judul,
          'tan_foto_ktp': base64FotoKTP,
          'tan_foto_kk': base64FotoKK,
          'tan_foto_sppt_shm': base64FotoSPPT_SHM,
          'tan_surat_konfirmasi': tan_surat_konfirmasi,
          'tan_tgl_upload': tan_tgl_upload,
          'tan_konfirmasi': tan_konfirmasi,
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
