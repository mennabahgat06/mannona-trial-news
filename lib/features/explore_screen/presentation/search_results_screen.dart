import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/widgets/custom_txt_field.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../article_screen/presentation/article_detail_screen.dart';
import '../data/models/article_model.dart';
import '../data/services/news_service.dart';
import 'widgets/explore_news_item.dart';

/// Search results (GET /v2/everything?q=...). Type again and press search.
class SearchResultsScreen extends StatefulWidget {
  final String initialQuery;

  const SearchResultsScreen({super.key, required this.initialQuery});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final NewsService _newsService = NewsService();
  late final TextEditingController _searchController =
      TextEditingController(text: widget.initialQuery);

  List<ArticleModel> _results = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _search();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final data = await _newsService.getEverything(query: query);
      if (mounted) setState(() => _results = data);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Search results', style: AppFonts.titleMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomTextField(
              controller: _searchController,
              hintText: 'Search news...',
              prefixIcon: Icons.search,
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 16),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _search);
    if (_results.isEmpty) {
      return const Center(
          child: Text('No results found.', style: AppFonts.bodyRegular));
    }

    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final article = _results[index];
        return ExploreNewsItem(
          article: article,
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
