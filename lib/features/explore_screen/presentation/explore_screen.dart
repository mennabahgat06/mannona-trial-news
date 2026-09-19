import 'package:flutter/material.dart';
import 'package:mannona_news/features/article_screen/article_detail_screen.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widgets/custom_txt_field.dart';
import '../data/models/article_model.dart';
import '../data/services/news_service.dart';
import 'search_results_screen.dart';
import 'widgets/category_chip.dart';
import 'widgets/explore_news_item.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final NewsService _newsService = NewsService();

  final List<String> _categories = [
    'All',
    'Travel',
    'Technology',
    'Business',
    'Science'
  ];
  String _selectedCat = 'All';

  List<ArticleModel> _articles = [];
  ArticleModel? _heroArticle;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() => _isLoading = true);
    final query = _selectedCat == 'All' ? 'nature' : _selectedCat.toLowerCase();
    final data = await _newsService.getEverything(query: query);

    if (mounted) {
      setState(() {
        if (data.isNotEmpty) {
          _heroArticle = data.first;
          _articles = data.sublist(1);
        } else {
          _heroArticle = null;
          _articles = [];
        }
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue))
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResultsScreen(
                                  initialQuery: _searchController.text.isEmpty
                                      ? 'Explore'
                                      : _searchController.text,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: _searchController,
                      hintText: 'Search news...',
                      prefixIcon: Icons.search,
                      onChanged: (val) {},
                      onClear: () {},
                    ),
                    const SizedBox(height: 16),
                    // Categories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _categories.map((cat) {
                          return CategoryChip(
                            label: cat,
                            isSelected: _selectedCat == cat,
                            onTap: () {
                              setState(() => _selectedCat = cat);
                              _fetchNews();
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Big Hero Card
                    if (_heroArticle != null) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticleDetailScreen(article: _heroArticle!),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: _heroArticle!.urlToImage != null
                                  ? Image.network(
                                      _heroArticle!.urlToImage!,
                                      height: 190,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        height: 190,
                                        color: AppColors.cardFill,
                                        child: const Icon(Icons.image,
                                            size: 40,
                                            color: AppColors.textLightGrey),
                                      ),
                                    )
                                  : Container(
                                      height: 190, color: AppColors.cardFill),
                            ),
                            const SizedBox(height: 10),
                            Text(_heroArticle!.title,
                                style: AppFonts.titleMedium),
                            const SizedBox(height: 4),
                            const Text(
                              '\${_heroArticle!.author ?? "Unknown"} · \${_heroArticle!.publishedAt ?? "Recent"}',
                              style: AppFonts.caption,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Articles list
                    ..._articles.map((art) => ExploreNewsItem(
                          article: art,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticleDetailScreen(article: art),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}
