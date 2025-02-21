import 'dart:convert';
import 'package:essentials/screens/pejabat/listadministrasi_pejabat_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KonfirmasiPenghasilanOrtuService {
  Future<void> KonfirmasiPenghasilanOrtu(String id_penghasilan, String has_konfirmasi, BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/konfirmasi_ad_penghasilan_ortu.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_penghasilan': id_penghasilan,
          'has_konfirmasi': has_konfirmasi,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil menyetujui pengajuan surat'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListVerifikasiPejabatScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal menyetujui pengajuan surat'),
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
