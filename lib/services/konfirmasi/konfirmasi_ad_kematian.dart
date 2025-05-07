import 'dart:convert';
import 'package:essentials/screens/pejabat/listadministrasi_pejabat_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KonfirmasiKematianService {
  Future<void> KonfirmasiKematian(String id_kematian, String kem_konfirmasi, BuildContext context) async {
    String url = 'https://essentials.my.id/konfirmasi_ad_kematian.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_kematian': id_kematian,
          'kem_konfirmasi': kem_konfirmasi,
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
