import 'package:flutter/material.dart';
import 'package:mannona_news/features/explore_screen/data/models/article_model.dart';
import '../../../../core/constants/app_colors.dart';

class PopularNewsCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;

  const PopularNewsCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                article.imagePath!,
                height: 130,
                width: 170,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
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
              style:
                  const TextStyle(fontSize: 11, color: AppColors.textLightGrey),
            ),
          ],
        ),
      ),
    );
  }
}
