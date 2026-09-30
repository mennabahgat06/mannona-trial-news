import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';

/// Shows an error message with a "Try again" button.
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 48, color: AppColors.textLightGrey),
            const SizedBox(height: 12),
            Text(message,
                textAlign: TextAlign.center, style: AppFonts.bodyRegular),
            const SizedBox(height: 12),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
