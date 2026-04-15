import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary — elegant teal/green
  static const Color primary = Color(0xFF0D9488);
  static const Color primaryDark = Color(0xFF0F766E);
  static const Color primaryLight = Color(0xFF5EEAD4);
  static const Color primaryContainer = Color(0xFFCCFBF1);

  // Surface & background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color backgroundLight = Color(0xFFF0FDF9);
  static const Color backgroundDark = Color(0xFF111827);

  // Neutral
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral900 = Color(0xFF111827);

  // Semantic
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color info = Color(0xFF2563EB);

  // Status chips
  static const Color confirmed = Color(0xFF0D9488);
  static const Color pending = Color(0xFFD97706);
  static const Color cancelled = Color(0xFFDC2626);
  static const Color completed = Color(0xFF6B7280);

  // Specialty category icons
  static const List<Color> specialtyColors = [
    Color(0xFF0D9488),
    Color(0xFF7C3AED),
    Color(0xFFDB2777),
    Color(0xFFD97706),
    Color(0xFF2563EB),
    Color(0xFF16A34A),
  ];
}
