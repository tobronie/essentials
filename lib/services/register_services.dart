import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  Future<void> register(String nama, String nik, String no_hp, String email, String password,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/register.php';

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

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil Membuat Akun'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal Membuat Akun'),
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
