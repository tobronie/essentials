// import 'package:essentials/firebase_options.dart';
// import 'package:essentials/screens/authentication/login_screen.dart';
// import 'package:essentials/screens/authentication/register_screen.dart';
// import 'package:essentials/screens/navigation/home_screen.dart';
// import 'package:essentials/screens/navigation/navigation.dart';
// import 'package:essentials/screens/onboarding_screen.dart';
// import 'package:essentials/services/firebase_auth_services.dart';
// // import 'package:essentials/theme/theme.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:essentials/screens/spalsh_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   var auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Essentials',
//       debugShowCheckedModeBanner: false,
//       // theme: modeGelap ? darkMode : lightMode,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const CheckUser(),
//         '/splash': (context) => const SplashScreen(),
//         '/onboarding': (context) => const OnboardingScreen(),
//         '/login': (context) => const LoginScreen(),
//         '/register': (context) => const RegisterScreen(),
//         '/home': (context) => const HomeScreen(),
//         '/navigation': (context) => const CustomNavigationBar(selectedIndex: 0),
//       },
//     );
//   }
// }

// class CheckUser extends StatefulWidget {
//   const CheckUser({super.key});

//   @override
//   State<CheckUser> createState() => _CheckUserState();
// }

// class _CheckUserState extends State<CheckUser> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero).then((_) {
//       FirebaseAuthService().isLoggedIn().then((isLoggedIn) {
//         Navigator.pushReplacementNamed(
//           context,
//           '/splash',
//           arguments: isLoggedIn ? '/home' : '/onboarding',
//         );
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox.shrink();
//   }
// }
