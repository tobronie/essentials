import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateKKService {
  Future<void> kk(
      String kk_judul,
      String? kk_foto_kk,
      String kk_foto_nikah_ayah,
      String kk_foto_nikah_ibu,
      String kk_foto_ijasah_keluarga,
      String kk_foto_akte_keluarga,
      String kk_surat_konfirmasi,
      String kk_tgl_upload,
      String kk_konfirmasi,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_kk.php';

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

    String base64FotoKK = '';
    String base64FotoNikahAyah = '';
    String base64FotoNikahIbu = '';
    String base64FotoIjasahKeluarga = '';
    String base64FotoAkteKeluarga = '';

    if (kk_foto_kk?.isNotEmpty ?? false) {
      try {
        base64FotoKK = base64Encode(File(kk_foto_kk!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Kartu Keluarga: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (kk_foto_nikah_ayah.isNotEmpty) {
      try {
        base64FotoNikahAyah = base64Encode(File(kk_foto_nikah_ayah).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Ayah: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (kk_foto_nikah_ibu.isNotEmpty) {
      try {
        base64FotoNikahIbu = base64Encode(File(kk_foto_nikah_ibu).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Ibu: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (kk_foto_ijasah_keluarga.isNotEmpty) {
      try {
        base64FotoIjasahKeluarga = base64Encode(File(kk_foto_ijasah_keluarga).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Ijasah Keluarga: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (kk_foto_akte_keluarga.isNotEmpty) {
      try {
        base64FotoAkteKeluarga = base64Encode(File(kk_foto_akte_keluarga).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Akte Keluarga: $e'),
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
          'id_user': id_user,
          'kk_judul': kk_judul,
          'kk_foto_kk': base64FotoKK.isNotEmpty ? base64FotoKK : '',
          'kk_foto_nikah_ayah': base64FotoNikahAyah,
          'kk_foto_nikah_ibu': base64FotoNikahIbu,
          'kk_foto_ijasah_keluarga': base64FotoIjasahKeluarga,
          'kk_foto_akte_keluarga': base64FotoAkteKeluarga,
          'kk_surat_konfirmasi': kk_surat_konfirmasi,
          'kk_tgl_upload': kk_tgl_upload,
          'kk_konfirmasi': kk_konfirmasi,
        },
      );
      print("ID User terkirim: $id_user");
      print("Response Body: ${response.body}");

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
