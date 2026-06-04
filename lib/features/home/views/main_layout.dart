// lib/features/home/views/main_layout.dart
import 'package:flutter/material.dart';

// Pastikan semua path import-nya benar ya boss
import '../../control_panel/views/control_panel_page.dart';
import 'home_page.dart';
import '../../activity/views/activity_page.dart'; // Kita taruh View All Activity di tab ke-3
import '../widgets/app_bottom_nav.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _activeNavIndex = 1; // Default ke HomePage (tengah)

  // Tumpukan kartu halamannya sekarang LENGKAP 3 SLOT
  final List<Widget> _pages = [
    const ControlPanelPage(), // Index 0 (Kiri - Ikon Joystick)
    const HomePage(),         // Index 1 (Tengah - Ikon Rumah)
    const ActivityPage(),     // Index 2 (Kanan - Ikon Panah/History)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: IndexedStack(
        index: _activeNavIndex,
        children: _pages,
      ),
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