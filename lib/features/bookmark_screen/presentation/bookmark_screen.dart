import 'package:flutter/material.dart';
import '../../../core/storage/bookmark_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/widgets/loading_view.dart';
import '../../article_screen/presentation/article_detail_screen.dart';
import '../../explore_screen/data/models/article_model.dart';
import '../../explore_screen/presentation/widgets/explore_news_item.dart';
import 'widgets/delete_bookmark_dialog.dart';

/// Screen 6 (Tab 2): saved articles. Long press an item to delete it.
class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<ArticleModel> _bookmarks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
    // Refresh automatically when an article is saved / removed anywhere.
    BookmarkStorage.bookmarkUpdateNotifier.addListener(_loadBookmarks);
  }

  @override
  void dispose() {
    BookmarkStorage.bookmarkUpdateNotifier.removeListener(_loadBookmarks);
    super.dispose();
  }

  Future<void> _loadBookmarks() async {
    final data = await BookmarkStorage.getBookmarks();
    if (!mounted) return;
    setState(() {
      _bookmarks = data;
      _isLoading = false;
    });
  }

  void _showDeleteDialog(ArticleModel article) {
    showDialog(
      context: context,
      builder: (_) => DeleteBookmarkDialog(
        article: article,
        onConfirm: () => BookmarkStorage.removeBookmark(article),
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_bookmarks.isEmpty) {
      return const Center(
        child: Text('No bookmarks saved yet.', style: AppFonts.bodyRegular),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      itemCount: _bookmarks.length,
      itemBuilder: (context, index) {
        final article = _bookmarks[index];
        return ExploreNewsItem(
          article: article,
          onLongPress: () => _showDeleteDialog(article),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ArticleDetailScreen(article: article)),
          ),
        );
      },
    );
  }
}
