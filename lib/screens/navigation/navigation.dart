import 'package:essentials/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:essentials/screens/navigation/home_screen.dart';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  const CustomNavigationBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late int selectedIndex;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userSession = Provider.of<UserSession>(context, listen: false);
      print("User yang login: ${userSession.id_user ?? "Belum Login"}");
    });
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color(0xffF9F9F9),
      color: Color(0xff00AA13),
      animationDuration: Duration(milliseconds: 300),
      height: 58,
      index: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ActivityScreen()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
      },
      items: [
        Icon(Icons.home_rounded, color: Colors.white, size: 32),
        Icon(Icons.history_rounded, color: Colors.white, size: 32),
        Icon(Icons.person_rounded, color: Colors.white, size: 32),
      ],
    );
  }
}
