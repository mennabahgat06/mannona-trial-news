import 'package:flutter/material.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/article_model.dart';

/// Big image + title + author for the first article in Explore.
class ExploreHeroCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;

  const ExploreHeroCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              url: article.urlToImage,
              height: 190,
              width: double.infinity,
              radius: 18,
            ),
            const SizedBox(height: 10),
            Text(article.title, style: AppFonts.titleMedium),
            const SizedBox(height: 4),
            Text(
              '${article.writer} · ${DateHelper.formatApiDate(article.publishedAt)}',
              style: AppFonts.caption,
            ),
          ],
        ),
      ),
    );
  }
}
