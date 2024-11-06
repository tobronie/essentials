import 'package:essentials/firebase_options.dart';
import 'package:essentials/screens/onboarding_screen.dart';
import 'package:essentials/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:essentials/screens/spalsh_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Essentials',
      debugShowCheckedModeBanner: false,
      theme: modeGelap ? darkMode : lightMode,
      home: auth.currentUser != null? SplashScreen() : OnboardingScreen(),
    );
  }
}