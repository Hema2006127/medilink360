import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

enum TagColor { blue, green, amber, red, purple, teal }

class AppTag extends StatelessWidget {
  final String label;
  final TagColor color;

  const AppTag({super.key, required this.label, this.color = TagColor.blue});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (color) {
      TagColor.blue   => (AppColors.blue3,   AppColors.blue),
      TagColor.green  => (AppColors.green2,  AppColors.green),
      TagColor.amber  => (AppColors.amber2,  AppColors.amber),
      TagColor.red    => (AppColors.red2,    AppColors.red),
      TagColor.purple => (AppColors.purple2, AppColors.purple),
      TagColor.teal   => (AppColors.teal2,   AppColors.teal),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: AppTextStyles.caption.copyWith(
        color: fg, fontWeight: FontWeight.w700, fontSize: 11,
      )),
    );
  }
}
