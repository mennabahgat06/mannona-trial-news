import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../article_screen/article_detail_screen.dart';
import '../home_screen/data/models/news_article_model.dart';
import 'presentation/widgets/bookmark_item_tile.dart';
import 'presentation/widgets/delete_bookmark_dialog.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final List<NewsArticleModel> _bookmarks = [
    NewsArticleModel(
      id: '1',
      title: 'How to Setup Your Workspace',
      category: 'Interior',
      author: 'Interior Pro',
      date: 'Apr 11, 2023',
      imagePath: AppAssets.newsRemote,
      content: 'Sample content about workspace setup.',
    ),
    NewsArticleModel(
      id: '2',
      title: 'Discovering Hidden Gems: 8 Off-The-Beaten-Path...',
      category: 'Travel',
      author: 'Traveler',
      date: 'Apr 10, 2023',
      imagePath: AppAssets.featuredJapan,
      content: 'Explore untouched places around the world.',
    ),
    NewsArticleModel(
      id: '3',
      title: 'Exploring the World\'s Best Beaches: Top 5 Picks',
      category: 'Travel',
      author: 'Explorer',
      date: 'Apr 09, 2023',
      imagePath: AppAssets.newsNature,
      content: 'Warm waters and golden sand selections.',
    ),
  ];

  void _showDeleteDialog(NewsArticleModel article) {
    showDialog(
      context: context,
      builder: (context) => DeleteBookmarkDialog(
        article: article,
        onConfirm: () {
          setState(() {
            _bookmarks.removeWhere((item) => item.id == article.id);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Bookmark', style: AppFonts.titleMedium),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          final article = _bookmarks[index];
          return BookmarkItemTile(
            article: article,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailScreen(article: article),
                ),
              );
            },
            onLongPress: () => _showDeleteDialog(article),
          );
        },
      ),
    );
  }
}
