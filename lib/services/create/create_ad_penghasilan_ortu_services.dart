import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePenghasilanOrtuService {
  Future<void> penghasilanOrtu(
      String has_judul,
      String has_pekerjaan_ayah,
      String has_pendapatan_ayah,
      String has_pekerjaan_ibu,
      String has_pendapatan_ibu,
      String has_foto_ktp,
      String has_foto_kk,
      String? has_foto_pendukung_ayah,
      String? has_foto_pendukung_ibu,
      String has_tgl_upload,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_penghasilan_ortu.php';

    String base64FotoKTP = '';
    String base64FotoKK = '';
    String base64FotoPendukungAyah = '';
    String base64FotoPendukungIbu = '';

    if (has_foto_ktp.isNotEmpty) {
      try {
        base64FotoKTP = base64Encode(File(has_foto_ktp).readAsBytesSync());
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

    if (has_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(has_foto_kk).readAsBytesSync());
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

    if (has_foto_pendukung_ayah?.isNotEmpty ?? false) {
      try {
        base64FotoPendukungAyah = base64Encode(File(has_foto_pendukung_ayah!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar pendukung ayah: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (has_foto_pendukung_ibu?.isNotEmpty ?? false) {
      try {
        base64FotoPendukungIbu = base64Encode(File(has_foto_pendukung_ibu!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar pendukung ibu: $e'),
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
          'has_judul': has_judul,
          'has_pekerjaan_ayah': has_pekerjaan_ayah,
          'has_pendapatan_ayah': has_pendapatan_ayah,
          'has_pekerjaan_ibu': has_pekerjaan_ibu,
          'has_pendapatan_ibu': has_pendapatan_ibu,
          'has_foto_ktp': base64FotoKTP,
          'has_foto_kk': base64FotoKK,
          'has_foto_pendukung_ayah': base64FotoPendukungAyah.isNotEmpty ? base64FotoPendukungAyah : '',
          'has_foto_pendukung_ibu': base64FotoPendukungIbu.isNotEmpty ? base64FotoPendukungIbu : '',
          'has_tgl_upload': has_tgl_upload,
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
