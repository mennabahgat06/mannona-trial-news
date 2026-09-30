import 'package:flutter/material.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/article_model.dart';

/// Row with title + author on the left and a small image on the right.
/// Used in Explore, Search results and Bookmarks.
class ExploreNewsItem extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const ExploreNewsItem({
    super.key,
    required this.article,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: Colors.transparent, // makes the whole row tappable
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
                    style: AppFonts.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${article.writer} · ${DateHelper.formatApiDate(article.publishedAt)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            AppNetworkImage(
                url: article.urlToImage, width: 75, height: 60, radius: 12),
          ],
        ),
      ),
    );
  }
}
