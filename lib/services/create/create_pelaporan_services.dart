import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateLaporService {
  Future<void> pelaporan(
      String judul_lapor,
      String waktu_lapor,
      String lokasi_lapor,
      String isi_lapor,
      String foto_lapor,
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

    String base64Image = '';
    if (foto_lapor.isNotEmpty) {
      try {
        base64Image = base64Encode(File(foto_lapor).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar: $e'),
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
          'judul_lapor': judul_lapor,
          'waktu_lapor': waktu_lapor,
          'lokasi_lapor': lokasi_lapor,
          'isi_lapor': isi_lapor,
          'foto_lapor': base64Image,
          'tgl_upload_lapor': tgl_upload_lapor,
          'konfirmasi_lapor': konfirmasi_lapor
        },
      );
      print("ID User terkirim: $id_user");
      print("Response Body: ${response.body}");

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil membuat Pengaduan'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActivityScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal membuat Pengaduan'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
