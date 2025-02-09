import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePendudukanService {
  Future<void> pendudukan(
      String pen_judul,
      String pen_foto_ktp,
      String pen_foto_kk,
      String? pen_foto_nikah_pria,
      String? pen_foto_nikah_wanita,
      String pen_daerah_asal,
      String pen_daerah_tujuan,
      String pen_tgl_upload,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_pendudukan.php';

    String base64FotoKTP = '';
    String base64FotoKK = '';
    String base64FotoNikahPria = '';
    String base64FotoNikahWanita = '';

    if (pen_foto_ktp.isNotEmpty) {
      try {
        base64FotoKTP = base64Encode(File(pen_foto_ktp).readAsBytesSync());
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

    if (pen_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(pen_foto_kk).readAsBytesSync());
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

    if (pen_foto_nikah_pria?.isNotEmpty ?? false) {
      try {
        base64FotoNikahPria = base64Encode(File(pen_foto_nikah_pria!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Pria: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (pen_foto_nikah_wanita?.isNotEmpty ?? false) {
      try {
        base64FotoNikahWanita = base64Encode(File(pen_foto_nikah_wanita!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Wanita: $e'),
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
          'pen_judul': pen_judul,
          'pen_foto_ktp': base64FotoKTP,
          'pen_foto_kk': base64FotoKK,
          'pen_foto_nikah_pria': base64FotoNikahPria.isNotEmpty ? base64FotoNikahPria : '',
          'pen_foto_nikah_wanita': base64FotoNikahWanita.isNotEmpty ? base64FotoNikahWanita : '',
          'pen_daerah_asal': pen_daerah_asal,
          'pen_daerah_tujuan': pen_daerah_tujuan,
          'pen_tgl_upload': pen_tgl_upload,
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
