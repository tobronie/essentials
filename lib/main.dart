import 'package:essentials/screens/authentication/login_screen.dart';
import 'package:essentials/screens/authentication/register_screen.dart';
import 'package:essentials/screens/navigation/home_screen.dart';
import 'package:essentials/screens/navigation/navigation.dart';
import 'package:essentials/screens/onboarding_screen.dart';
import 'package:essentials/services/save_information.dart';
import 'package:flutter/material.dart';
import 'package:essentials/screens/spalsh_screen.dart';
import 'package:provider/provider.dart';
import 'package:essentials/services/user_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userSession = UserSession();
  await userSession.loadUserData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userSession),
        ChangeNotifierProvider(create: (context) => BookmarkProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Essentials',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CheckUser(),
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/navigation': (context) => const CustomNavigationBar(selectedIndex: 0),
      },
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, checkLoginStatus);
  }

  void checkLoginStatus() {
    final userSession = Provider.of<UserSession>(context, listen: false);

    if (userSession.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
