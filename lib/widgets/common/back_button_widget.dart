import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final bool white;

  const BackButtonWidget({super.key, this.onTap, this.white = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.maybePop(context),
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: white
            ? Colors.white.withValues(alpha: 0.2)
            : AppColors.s2,
          border: Border.all(
            color: white
              ? Colors.white.withValues(alpha: 0.3)
              : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(
          Icons.arrow_back,
          size: 16,
          color: white ? Colors.white : AppColors.text,
        ),
      ),
    );
  }
}
