import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_content_page.dart';
import 'edukasi_page.dart';
import 'login_page.dart';
import 'riwayat_page.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;

  final Color activeColor = const Color(0xFF2A32AA);
  final Color barColor = const Color(0xFFD8E1FB); // Biru muda

  final List<Widget> _pages = [
    const HomeContentPage(),
    const EdukasiPage(),
    const SizedBox(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) async {
    if (index == 2) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (!mounted) return;

      if (token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RiwayatPage()),
        );
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: activeColor,
        unselectedItemColor: Colors.black54,
        backgroundColor: const Color.fromARGB(255, 227, 232, 244), 
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Edukasi'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
