import 'dart:convert';
import 'package:essentials/user_session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginService {
  Future<String?> login(
      String email, String password, BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/login.php';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'password': password,
        },
      );

      var data = jsonDecode(response.body);
      print("Response dari API Register: $data");

      if (response.statusCode == 200 && data['success'] == 'true') {
        String id_user = data['id_user'].toString();
        print("ID User yang diterima setelah register: $id_user");
        await Provider.of<UserSession>(context, listen: false).saveUser(id_user);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil Masuk'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamed(context, '/home');
        return id_user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal Masuk'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }
}
