import 'package:flutter/material.dart';
import '../../../core/storage/user_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../article_screen/presentation/article_detail_screen.dart';
import '../../explore_screen/data/models/article_model.dart';
import '../../explore_screen/data/services/news_service.dart';
import '../../weather_screen/data/models/weather_model.dart';
import '../../weather_screen/data/services/weather_service.dart';
import 'widgets/featured_news_card.dart';
import 'widgets/home_header.dart';
import 'widgets/popular_news_card.dart';

/// Screen 4 (Tab 0): greeting + weather, featured article, "Most Popular".
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();
  final WeatherService _weatherService = WeatherService();

  String _userName = '';
  WeatherModel? _weather;
  ArticleModel? _featured;
  List<ArticleModel> _popular = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    _userName = await UserStorage.getUserName() ?? '';
    _loadWeather(); // weather loads on its own, it must not block the news

    try {
      final headlines = await _newsService.getTopHeadlines();
      if (!mounted) return;
      setState(() {
        _featured = headlines.isNotEmpty ? headlines.first : null;
        _popular = headlines.length > 1 ? headlines.sublist(1) : [];
      });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loadWeather() async {
    try {
      final weather = await _weatherService.getWeather(
        lat: await UserStorage.getLat(),
        lon: await UserStorage.getLon(),
      );
      if (mounted) setState(() => _weather = weather);
    } catch (_) {
      // The header simply hides the weather chip.
    }
  }

  void _openArticle(ArticleModel article) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Full-screen loader only on the first load (pull-to-refresh keeps the list).
    if (_isLoading && _featured == null) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _loadData);

    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.primaryBlue,
        onRefresh: _loadData,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            HomeHeader(userName: _userName, weather: _weather),
            const SizedBox(height: 20),
            if (_featured != null)
              FeaturedNewsCard(
                article: _featured!,
                onTap: () => _openArticle(_featured!),
              ),
            const SizedBox(height: 24),
            const Text('Most Popular', style: AppFonts.titleMedium),
            const SizedBox(height: 14),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _popular.length,
                itemBuilder: (context, index) => PopularNewsCard(
                  article: _popular[index],
                  onTap: () => _openArticle(_popular[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
