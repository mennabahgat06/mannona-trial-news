import 'package:flutter/material.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../explore_screen/data/models/article_model.dart';

/// Small card in the horizontal "Most Popular" list.
class PopularNewsCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;

  const PopularNewsCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
                url: article.urlToImage, height: 120, width: 150, radius: 16),
            const SizedBox(height: 6),
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.titleSmall.copyWith(fontSize: 12),
            ),
            Text(
              article.writer,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.caption,
            ),
          ],
        ),
      ),
    );
  }
}
