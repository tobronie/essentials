import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession with ChangeNotifier {
  String? _id_user;
  bool _isLoggedIn = false;

  String? get id_user => _id_user;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id_user = prefs.getString('id_user');
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  Future<void> saveUser(String id_user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_user', id_user);
    await prefs.setBool('isLoggedIn', true);
    _id_user = id_user;
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _id_user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
