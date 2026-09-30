import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';

/// Rounded blue button used on Welcome, Location and Weather screens.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: AppFonts.buttonText),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 16, color: AppColors.white),
            ],
          ],
        ),
      ),
    );
  }
}
