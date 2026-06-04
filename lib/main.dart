// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/theme/app_theme.dart';
import 'features/activity/repositories/activity_repository.dart';
import 'features/home/views/main_layout.dart'; // <-- Import Layout-nya boss

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ActivityRepository.instance.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ArcPanelApp());
}

class ArcPanelApp extends StatelessWidget {
  const ArcPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arc Panel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const MainLayout(), // <-- Tembak langsung ke MainLayout
    );
  }
}