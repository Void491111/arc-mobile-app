// lib/features/home/views/main_layout.dart
import 'package:flutter/material.dart';

import 'home_page.dart';
import '../../control_cabinet/views/control_cabinet_page.dart';
import '../../activity/views/activity_page.dart';
import '../widgets/app_bottom_nav.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _activeNavIndex = 1; // Default ke HomePage (tengah)

  // Tumpukan kartu halamannya boss
  final List<Widget> _pages = [
    const Scaffold(body: Center(child: Text('Halaman Machine Control'))), // Index 0
    const HomePage(),           // Index 1
    const ControlCabinetPage(),       // Index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: IndexedStack(
        index: _activeNavIndex,
        children: _pages,
      ),
      // Pindahkan AppBottomNav boss ke sini!
      bottomNavigationBar: AppBottomNav(
        activeIndex: _activeNavIndex,
        onTap: (i) {
          setState(() {
            _activeNavIndex = i;
          });
        },
      ),
    );
  }
}