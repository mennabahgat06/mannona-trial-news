import 'package:flutter/material.dart';
import 'package:mannona_news/features/explore_screen/data/models/article_model.dart';
import '../../../../core/constants/app_colors.dart';

class BookmarkItemTile extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const BookmarkItemTile({
    super.key,
    required this.article,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.category!,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textLightGrey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                article.imagePath!,
                width: 70,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
