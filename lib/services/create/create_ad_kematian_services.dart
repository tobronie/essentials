import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateKematianService {
  Future<void> kematian(
      String kem_judul,
      String kem_nama_almarhum,
      String kem_foto_ktp_almarhum,
      String kem_foto_kk,
      String? kem_foto_surat_kematian,
      String kem_foto_ktp_saksi,
      String kem_surat_konfirmasi,
      String kem_tgl_upload,
      String kem_konfirmasi,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_kematian.php';

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

    String base64FotoKTPalmarhum = '';
    String base64FotoKK = '';
    String base64FotoSuratKematian = '';
    String base64FotoKTPsaksi = '';

    if (kem_foto_ktp_almarhum.isNotEmpty) {
      try {
        base64FotoKTPalmarhum = base64Encode(File(kem_foto_ktp_almarhum).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar ktp almarhum: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (kem_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(kem_foto_kk).readAsBytesSync());
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

    if (kem_foto_surat_kematian?.isNotEmpty ?? false) {
      try {
        base64FotoSuratKematian = base64Encode(File(kem_foto_surat_kematian!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar surat kematian: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (kem_foto_ktp_saksi.isNotEmpty) {
      try {
        base64FotoKTPsaksi = base64Encode(File(kem_foto_ktp_saksi).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar ktp saksi: $e'),
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
          'kem_judul': kem_judul,
          'kem_nama_almarhum': kem_nama_almarhum,
          'kem_foto_ktp_almarhum': base64FotoKTPalmarhum,
          'kem_foto_kk': base64FotoKK,
          'kem_foto_surat_kematian': base64FotoSuratKematian.isNotEmpty ? base64FotoSuratKematian : '',
          'kem_foto_ktp_saksi': base64FotoKTPsaksi,
          'kem_surat_konfirmasi': kem_surat_konfirmasi,
          'kem_tgl_upload': kem_tgl_upload,
          'kem_konfirmasi': kem_konfirmasi,
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
