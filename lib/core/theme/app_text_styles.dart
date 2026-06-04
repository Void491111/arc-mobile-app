import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ===== Header / sections (tetep Poppins) =====
  static TextStyle get greeting => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get pageTitle => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.1,
      );

  static TextStyle get sectionTitle => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionAction => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      );

  static TextStyle get emptyState => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      );

  static TextStyle get todoTitle => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  // ===== Status card (Roboto) =====
  static TextStyle get statusPill => GoogleFonts.roboto(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 1.2,
      );

  static TextStyle get statusDate => GoogleFonts.roboto(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      );

  static TextStyle get statusLabel => GoogleFonts.roboto(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Colors.white.withValues(alpha: 0.85),
      );

  static TextStyle get statusValue => GoogleFonts.roboto(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.05,
      );

  static TextStyle get statusClock => GoogleFonts.roboto(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.0,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get statusUptimeLabel => GoogleFonts.roboto(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Colors.white.withValues(alpha: 0.9),
      );

  static TextStyle get statusUptimeValue => GoogleFonts.roboto(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFeatures: const [FontFeature.tabularFigures()],
      );
}