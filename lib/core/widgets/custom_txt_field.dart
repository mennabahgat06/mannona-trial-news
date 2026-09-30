import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// The shared search / input field used across the app.
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      // Rebuild when the text changes so the clear (x) button shows / hides.
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          return TextField(
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: prefixIcon == null
                  ? null
                  : Icon(prefixIcon, color: AppColors.textGrey, size: 20),
              suffixIcon: value.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close,
                          color: AppColors.textGrey, size: 18),
                      onPressed: () {
                        controller.clear();
                        onClear?.call();
                      },
                    ),
              hintText: hintText,
              hintStyle:
                  const TextStyle(fontSize: 13, color: AppColors.textLightGrey),
            ),
          );
        },
      ),
    );
  }
}
