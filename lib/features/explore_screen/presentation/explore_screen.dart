import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/widgets/custom_txt_field.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../article_screen/presentation/article_detail_screen.dart';
import '../data/models/article_model.dart';
import '../data/services/news_service.dart';
import 'search_results_screen.dart';
import 'widgets/categories_bar.dart';
import 'widgets/explore_hero_card.dart';
import 'widgets/explore_news_item.dart';

/// Screen 5 (Tab 1): search box, categories, hero article and a list.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const List<String> _categories = [
    'All',
    'Travel',
    'Technology',
    'Business',
    'Science',
  ];

  final TextEditingController _searchController = TextEditingController();
  final NewsService _newsService = NewsService();

  String _selectedCategory = 'All';
  List<ArticleModel> _articles = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchNews() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final query =
          _selectedCategory == 'All' ? 'nature' : _selectedCategory.toLowerCase();
      final data = await _newsService.getEverything(query: query);
      if (mounted) setState(() => _articles = data);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onCategorySelected(String category) {
    setState(() => _selectedCategory = category);
    _fetchNews();
  }

  void _openSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SearchResultsScreen(initialQuery: query)),
    );
  }

  void _openArticle(ArticleModel article) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Explore', style: AppFonts.headerLarge),
                IconButton(
                  icon: const Icon(Icons.search,
                      size: 22, color: AppColors.textDark),
                  onPressed: _openSearch,
                ),
              ],
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _searchController,
              hintText: 'Search news...',
              prefixIcon: Icons.search,
              onSubmitted: (_) => _openSearch(),
            ),
            const SizedBox(height: 16),
            CategoriesBar(
              categories: _categories,
              selected: _selectedCategory,
              onSelected: _onCategorySelected,
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _fetchNews);
    if (_articles.isEmpty) {
      return const Center(
          child: Text('No articles found.', style: AppFonts.bodyRegular));
    }

    return ListView.builder(
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        final article = _articles[index];
        // The first article is shown as a big "hero" card.
        if (index == 0) {
          return ExploreHeroCard(
              article: article, onTap: () => _openArticle(article));
        }
        return ExploreNewsItem(
            article: article, onTap: () => _openArticle(article));
      },
    );
  }
}
