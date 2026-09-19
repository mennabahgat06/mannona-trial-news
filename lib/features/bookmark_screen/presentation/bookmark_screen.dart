import 'package:flutter/material.dart';
import 'package:mannona_news/features/article_screen/article_detail_screen.dart';
import 'package:mannona_news/features/explore_screen/data/models/article_model.dart';
import 'package:mannona_news/features/explore_screen/presentation/widgets/explore_news_item.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/storage/bookmark_storage.dart';
import 'widgets/delete_bookmark_dialog.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<ArticleModel> _bookmarks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    setState(() => _isLoading = true);
    final data = await BookmarkStorage.getBookmarks();
    if (mounted) {
      setState(() {
        _bookmarks = data;
        _isLoading = false;
      });
    }
  }

  void _showDeleteDialog(ArticleModel article) {
    showDialog(
      context: context,
      builder: (context) => DeleteBookmarkDialog(
        article: article,
        onConfirm: () async {
          await BookmarkStorage.removeBookmark(article.title);
          _loadBookmarks();
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
        title: const Text('Bookmark', style: AppFonts.titleMedium),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue))
          : _bookmarks.isEmpty
              ? const Center(
                  child: Text('No bookmarks saved yet.',
                      style: AppFonts.bodyRegular),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  itemCount: _bookmarks.length,
                  itemBuilder: (context, index) {
                    final article = _bookmarks[index];
                    return GestureDetector(
                      onLongPress: () => _showDeleteDialog(article),
                      child: ExploreNewsItem(
                        article: article,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticleDetailScreen(article: article),
                            ),
                          );
                          _loadBookmarks();
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
