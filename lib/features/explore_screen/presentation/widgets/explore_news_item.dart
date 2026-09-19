import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/article_model.dart';

class ExploreNewsItem extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;

  const ExploreNewsItem({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  const SizedBox(height: 6),
                  const Text(
                    '\${article.author ?? "Unknown"} · \${article.publishedAt ?? "Today"}',
                    style:
                        TextStyle(fontSize: 11, color: AppColors.textLightGrey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  article.urlToImage != null && article.urlToImage!.isNotEmpty
                      ? Image.network(
                          article.urlToImage!,
                          width: 75,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 75,
                            height: 60,
                            color: AppColors.cardFill,
                            child: const Icon(Icons.newspaper,
                                color: AppColors.textLightGrey),
                          ),
                        )
                      : Container(
                          width: 75,
                          height: 60,
                          color: AppColors.cardFill,
                          child: const Icon(Icons.newspaper,
                              color: AppColors.textLightGrey),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
