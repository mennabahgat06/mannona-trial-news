import 'package:flutter/material.dart';
import 'package:mannona_news/features/explore_screen/data/models/article_model.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../article_screen/article_detail_screen.dart';
import '../bookmark_screen/bookmark_screen.dart';
import 'presentation/widgets/custom_bottom_nav_bar.dart';
import 'presentation/widgets/featured_news_card.dart';
import 'presentation/widgets/popular_news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  final List<ArticleModel> _popularNews = [
    ArticleModel(
      id: '1',
      title: 'The Pros and Cons of Remote Work',
      category: 'Technology',
      author: 'Harry Harper',
      date: 'Apr 12, 2023',
      imagePath: AppAssets.newsRemote,
      content:
          'Forests are one of the most important natural resources that our planet possesses. Not only do they provide us with a diverse range of products such as timber, medicine, and food, but they also play a vital role in mitigating climate change.',
    ),
    ArticleModel(
      id: '2',
      title: 'Exploring Nature and Forests',
      category: 'Environment',
      author: 'Luc Olinga',
      date: 'Apr 10, 2023',
      imagePath: AppAssets.newsNature,
      content:
          'Trees absorb carbon dioxide from the atmosphere through photosynthesis and store it in their trunks, branches, and leaves.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning,\nAhmed Saber',
                          style: AppFonts.caption
                              .copyWith(color: AppColors.textGrey)),
                      const SizedBox(height: 2),
                      const Text('Sun 9 April, 2023',
                          style: AppFonts.titleMedium),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.wb_sunny_outlined,
                          size: 18, color: Colors.orange),
                      SizedBox(width: 4),
                      Text('Sunny 32°C', style: AppFonts.caption),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FeaturedNewsCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailScreen(article: _popularNews.first),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Most Popular', style: AppFonts.titleMedium),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See More',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.primaryBlue)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _popularNews.length,
                  itemBuilder: (context, index) {
                    final article = _popularNews[index];
                    return PopularNewsCard(
                      article: article,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ArticleDetailScreen(article: article),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _navIndex,
        onItemTapped: (index) {
          setState(() => _navIndex = index);
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookmarkScreen()),
            );
          }
        },
      ),
    );
  }
}
