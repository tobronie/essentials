import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:essentials/services/user_session.dart';

class UpdateProfilService {
  Future<void> userProfil(String base64Image, BuildContext context) async {
    final userSession = Provider.of<UserSession>(context, listen: false);
    String id_user = userSession.id_user ?? "";

    if (id_user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal: ID pengguna tidak ditemukan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String url = 'https://essentials.my.id/update_profil.php';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_user': id_user,
          'profil': base64Image,
        },
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil memperbarui foto profil!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, '/profile');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal memperbarui foto profil'),
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
