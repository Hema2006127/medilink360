import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool outline;
  final bool loading;
  final Color? color;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.outline = false,
    this.loading = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: outline ? Colors.transparent : (color ?? AppColors.blue),
          border: Border.all(
            color: outline ? AppColors.border2 : Colors.transparent, width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: outline ? null : [
            BoxShadow(
              color: (color ?? AppColors.blue).withValues(alpha: 0.35),
              blurRadius: 20, offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: loading
            ? const SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2,
                ),
              )
            : Text(label, style: AppTextStyles.bodyBold.copyWith(
                color: outline ? AppColors.text2 : Colors.white,
                fontSize: 14,
              )),
        ),
      ),
    );
  }
}
