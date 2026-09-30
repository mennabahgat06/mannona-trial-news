import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// White floating field at the top of the map for the user name.
class NameInputBar extends StatelessWidget {
  final TextEditingController controller;

  const NameInputBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon:
              Icon(Icons.person_outline, color: AppColors.textGrey, size: 20),
          hintText: 'Enter your name...',
        ),
      ),
    );
  }
}
