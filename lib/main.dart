import 'package:essentials/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:essentials/screens/spalsh_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Essentials',
      debugShowCheckedModeBanner: false,
      theme: modeGelap ? darkMode : lightMode,
      home: SplashScreen(),
    );
  }
}
