import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/storage/bookmark_storage.dart';
import '../../explore_screen/data/models/article_model.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final status = await BookmarkStorage.isBookmarked(widget.article.title);
    if (mounted) setState(() => _isBookmarked = status);
  }

  Future<void> _toggleBookmark() async {
    await BookmarkStorage.toggleBookmark(widget.article);
    setState(() => _isBookmarked = !_isBookmarked);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _isBookmarked ? 'Article bookmarked!' : 'Removed from bookmarks'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 320,
            child: widget.article.urlToImage != null &&
                    widget.article.urlToImage!.isNotEmpty
                ? Image.network(
                    widget.article.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.cardFill,
                      child: const Icon(Icons.image,
                          size: 50, color: AppColors.textLightGrey),
                    ),
                  )
                : Container(color: AppColors.cardFill),
          ),
          Positioned.fill(
            top: 270,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                _isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                size: 22,
                                color: _isBookmarked
                                    ? AppColors.primaryBlue
                                    : AppColors.textDark,
                              ),
                              onPressed: _toggleBookmark,
                            ),
                            IconButton(
                              icon: const Icon(Icons.share_outlined, size: 20),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(widget.article.title, style: AppFonts.headerLarge),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.cardFill,
                          child: Icon(Icons.person,
                              size: 14, color: AppColors.textGrey),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '\${widget.article.author ?? "Unknown Author"} · \${widget.article.publishedAt ?? "Recent"}',
                            style: AppFonts.caption,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.article.content?.isNotEmpty == true
                          ? widget.article.content!
                          : widget.article.description ??
                              'No content available.',
                      style: AppFonts.bodyRegular
                          .copyWith(color: AppColors.textDark, fontSize: 14),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
