import 'dart:convert';
import 'package:essentials/screens/pejabat/listadministrasi_pejabat_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KonfirmasiPendudukanService {
  Future<void> KonfirmasiPendudukan(String id_pendudukan, String pen_konfirmasi, BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/konfirmasi_ad_pendudukan.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_pendudukan': id_pendudukan,
          'pen_konfirmasi': pen_konfirmasi,
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
