import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:essentials/screens/admin/listlaporan_admin_screen.dart';
import 'package:essentials/screens/admin/listadministrasi_admin_screen.dart';
import 'package:essentials/screens/admin/listinformasi_admin_screen.dart';

class AdminCustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  const AdminCustomNavigationBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _AdminCustomNavigationBarState createState() => _AdminCustomNavigationBarState();
}

class _AdminCustomNavigationBarState extends State<AdminCustomNavigationBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color(0xffF9F9F9),
      color: Color(0xFF0D0140),
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
            MaterialPageRoute(builder: (context) => ListVerifikasiLaporanAdminScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ListVerifikasiAdministrasiAdminScreen()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ListInformasiAdminScreen()),
          );
        }
      },
      items: [
        Icon(Icons.article_rounded, color: Colors.white, size: 32),
         Icon(Icons.description_rounded, color: Colors.white, size: 32),
        Icon(Icons.edit_document, color: Colors.white, size: 32),
      ],
    );
  }
}
