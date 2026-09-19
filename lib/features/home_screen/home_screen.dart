import 'package:flutter/material.dart';
import 'package:mannona_news/features/article_screen/article_detail_screen.dart';
import 'package:mannona_news/features/explore_screen/data/models/article_model.dart';
import 'package:mannona_news/features/explore_screen/data/services/news_service.dart';
import 'package:mannona_news/features/weather_screen/data/models/weather_model.dart';
import 'package:mannona_news/features/weather_screen/data/services/weather_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();
  final WeatherService _weatherService = WeatherService();

  WeatherModel? _weather;
  List<ArticleModel> _popularNews = [];
  ArticleModel? _heroArticle;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final weather = await _weatherService.getWeather();
    final headlines = await _newsService.getTopHeadlines();
    if (mounted) {
      setState(() {
        _weather = weather;
        if (headlines.isNotEmpty) {
          _heroArticle = headlines.first;
          _popularNews = headlines.sublist(1);
        }
        _isLoading = false;
      });
    }
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
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Good Morning,\nAhmed Saber',
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.textGrey)),
                            SizedBox(height: 2),
                            Text('Sun 9 April, 2023',
                                style: AppFonts.titleMedium),
                          ],
                        ),
                        if (_weather != null)
                          Row(
                            children: [
                              const Icon(Icons.wb_sunny_outlined,
                                  size: 18, color: AppColors.sunnyYellow),
                              const SizedBox(width: 4),
                              Text('Sunny ${_weather!.temp.round()}°C',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_heroArticle != null)
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ArticleDetailScreen(
                                    article: _heroArticle!))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Image.network(
                                _heroArticle!.urlToImage ?? '',
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                    height: 220, color: AppColors.cardFill),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.8)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_heroArticle!.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(_heroArticle!.author ?? 'Luc Olinga',
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 11)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    const Text('Most Popular', style: AppFonts.titleMedium),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _popularNews.length,
                        itemBuilder: (context, index) {
                          final art = _popularNews[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ArticleDetailScreen(article: art))),
                            child: Container(
                              width: 145,
                              margin: const EdgeInsets.only(right: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      art.urlToImage ?? '',
                                      height: 120,
                                      width: 145,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                          height: 120,
                                          color: AppColors.cardFill),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(art.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text(art.category ?? 'News',
                                      style: AppFonts.caption),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
