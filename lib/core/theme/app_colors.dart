import 'package:flutter/material.dart';

/// Semua warna app ada di sini biar gampang di-tweak satu tempat.
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color background = Color(0xFFF5F5F7);
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  // Status card (red gradient)
  static const Color statusRedStart = Color(0xFFE53935);
  static const Color statusRedEnd = Color(0xFFC62828);
  static const Color statusPillBg = Color(0xFF8B1A1A);
  static const Color statusDot = Color(0xFFFBBF24);

  // Accents
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentPurple = Color(0xFF7C3AED);
  static const Color accentRed = Color(0xFFEF4444);

  // Borders & dividers
  static const Color border = Color(0xFFE5E7EB);

  // Bottom nav
  static const Color bottomNavBg = Color(0xFFE8E8EB);
  static const Color bottomNavInactive = Color(0xFF6B7280);
}