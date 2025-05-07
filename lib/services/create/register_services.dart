import 'dart:convert';
import 'package:essentials/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RegisterService {
  Future<String?> register(String nama, String nik, String no_hp, String email,
      String password, BuildContext context) async {
    String url = 'https://essentials.my.id/register.php';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'nama': nama,
          'nik': nik,
          'no_hp': no_hp,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200 || response.body.isEmpty) {
        throw Exception('Server tidak merespons dengan benar');
      }

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        String id_user = data['id_user'].toString();
        await Provider.of<UserSession>(context, listen: false)
            .saveUser(id_user);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil Membuat Akun'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamed(context, '/home');
        return id_user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal Membuat Akun'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }
}