import 'dart:convert';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:essentials/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UpdateUserService {
  Future<void> user(String kk, String dusun, String rt, String rw,
      String pekerjaan, BuildContext context) async {
    final userSession = Provider.of<UserSession>(context, listen: false);
    String id_user = userSession.id_user ?? "";

    if (id_user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Gagal memperbarui informasi: ID pengguna tidak ditemukan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String url = 'http://10.0.2.2:8080/essentials_api/update_user.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_user': id_user,
          'kk': kk,
          'dusun': dusun,
          'rt': rt,
          'rw': rw,
          'pekerjaan': pekerjaan,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil melengkapi data'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal melengkapi data'),
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
