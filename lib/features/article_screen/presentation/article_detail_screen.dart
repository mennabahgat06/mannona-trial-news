import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/storage/bookmark_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/date_helper.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../explore_screen/data/models/article_model.dart';
import 'widgets/article_action_bar.dart';

/// Article details: image on top, white sheet with title, author and text.
class ArticleDetailScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool _isBookmarked = false;

  ArticleModel get _article => widget.article;

  @override
  void initState() {
    super.initState();
    BookmarkStorage.isBookmarked(_article).then((saved) {
      if (mounted) setState(() => _isBookmarked = saved);
    });
  }

  Future<void> _toggleBookmark() async {
    final saved = await BookmarkStorage.toggleBookmark(_article);
    if (!mounted) return;
    setState(() => _isBookmarked = saved);
    _showMessage(saved ? 'Article bookmarked!' : 'Removed from bookmarks');
  }

  /// Copies the article link so the user can paste it anywhere.
  Future<void> _share() async {
    final link = _article.url;
    if (link == null || link.isEmpty) {
      _showMessage('This article has no link to share.');
      return;
    }
    await Clipboard.setData(ClipboardData(text: link));
    _showMessage('Link copied to clipboard');
  }

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: const Duration(seconds: 1)),
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
            child: AppNetworkImage(url: _article.urlToImage),
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
                    ArticleActionBar(
                      isBookmarked: _isBookmarked,
                      onBack: () => Navigator.pop(context),
                      onBookmark: _toggleBookmark,
                      onShare: _share,
                    ),
                    const SizedBox(height: 12),
                    Text(_article.title, style: AppFonts.headerLarge),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.cardFill,
                          child: Icon(Icons.person,
                              size: 14, color: AppColors.textGrey),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${_article.writer} · ${DateHelper.formatApiDate(_article.publishedAt)}',
                            style: AppFonts.caption,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _article.body,
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
