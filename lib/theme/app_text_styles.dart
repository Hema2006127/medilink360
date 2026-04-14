import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _base => GoogleFonts.plusJakartaSans();

  // Headings
  static TextStyle get h1 => _base.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    color: AppColors.text,
    letterSpacing: -1,
  );
  static TextStyle get h2 => _base.copyWith(
    fontSize: 26,
    fontWeight: FontWeight.w900,
    color: AppColors.text,
    letterSpacing: -0.5,
  );
  static TextStyle get h3 => _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.text,
  );
  static TextStyle get h4 => _base.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );

  // Body
  static TextStyle get body => _base.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static TextStyle get bodyMedium => _base.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static TextStyle get bodyBold => _base.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  // Labels
  static TextStyle get label => _base.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.text2,
    letterSpacing: 0.5,
  );
  static TextStyle get caption => _base.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.text3,
  );

  // White variants (for dark backgrounds)
  static TextStyle get h1White => h1.copyWith(color: Colors.white);
  static TextStyle get h2White => h2.copyWith(color: Colors.white);
  static TextStyle get h3White => h3.copyWith(color: Colors.white);
  static TextStyle get bodyWhite => body.copyWith(color: Colors.white);
  static TextStyle get captionWhite =>
      caption.copyWith(color: Colors.white.withValues(alpha: 0.65));

  // Blue variants
  static TextStyle get bodyBlue =>
      body.copyWith(color: const Color.fromARGB(255, 209, 210, 212));
  static TextStyle get labelBlue => label.copyWith(color: AppColors.blue);
}
