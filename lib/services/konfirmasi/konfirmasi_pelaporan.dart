import 'dart:convert';
import 'package:essentials/screens/admin/listlaporan_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdatePengaduanService {
  Future<void> Pengaduan(String id_lapor, String konfirmasi_lapor, BuildContext context) async {
    String url = 'https://essentials.my.id/konfirmasi_pelaporan.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_lapor': id_lapor,
          'konfirmasi_lapor': konfirmasi_lapor,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil menyetujui pengaduan'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListVerifikasiLaporanAdminScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal menyetujui pengaduan'),
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
