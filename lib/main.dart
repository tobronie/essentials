import 'package:essentials/firebase_options.dart';
import 'package:essentials/screens/authentication/login_screen.dart';
import 'package:essentials/screens/authentication/register_screen.dart';
import 'package:essentials/screens/navigation/navigation.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Essentials',
      debugShowCheckedModeBanner: false,
      theme: modeGelap ? darkMode : lightMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/navigation': (context) => const CustomNavigationBar(selectedIndex: 0),
      },
    );
  }
}
