import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF1B56F5);
  static const Color blue = primary;
  static const Color secondary = Color(0xFF1444CC);
  static const Color blue3 = Color(0xFFE8EFFE);
  static const Color blue4 = Color(0xFFD0DAFF);
  static const Color darkBlue = Color(0xFF0D2FA8);

  // Backgrounds
  static const Color bg = Color(0xFFF0F4FF);
  static const Color s2 = Color(0xFFF7F9FF);

  // Borders
  static const Color border = Color(0xFFE2E8FF);
  static const Color border2 = Color(0xFFC5D0F5);

  // Text
  static const Color text = Color(0xFF0D1B3E);
  static const Color text2 = Color(0xFF5A6A8A);
  static const Color text3 = Color(0xFF9AAAC8);

  // Status
  static const Color green = Color(0xFF0EB87A);
  static const Color green2 = Color(0xFFE0F7EE);
  static const Color amber = Color(0xFFF59E0B);
  static const Color amber2 = Color(0xFFFEF3C7);
  static const Color red = Color(0xFFEF4444);
  static const Color red2 = Color(0xFFFEE2E2);
  static const Color pink = Color(0xFFEC4899);
  static const Color pink2 = Color(0xFFFCE7F3);
  static const Color purple = Color(0xFF7C3AED);
  static const Color purple2 = Color(0xFFEDE9FE);
  static const Color teal = Color(0xFF0D9488);
  static const Color teal2 = Color(0xFFCCFBF1);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary, darkBlue],
    stops: [0.0, 0.55, 1.0],
  );

  static const LinearGradient doctorHeaderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue3, darkBlue],
  );
}
