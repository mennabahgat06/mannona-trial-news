import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// Back button on the left, bookmark + share on the right.
class ArticleActionBar extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback onBack;
  final VoidCallback onBookmark;
  final VoidCallback onShare;

  const ArticleActionBar({
    super.key,
    required this.isBookmarked,
    required this.onBack,
    required this.onBookmark,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: onBack),
        Row(
          children: [
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                size: 22,
                color: isBookmarked ? AppColors.primaryBlue : AppColors.textDark,
              ),
              onPressed: onBookmark,
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined, size: 20),
              onPressed: onShare,
            ),
          ],
        ),
      ],
    );
  }
}
