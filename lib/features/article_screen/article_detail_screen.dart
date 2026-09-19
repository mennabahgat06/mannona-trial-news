import 'package:flutter/material.dart';
import 'package:mannona_news/features/explore_screen/data/models/article_model.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool _isBookmarked = false;

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
            height: 280,
            child: Image.asset(
              AppAssets.articleForest,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 230,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                _isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                size: 20,
                                color: _isBookmarked
                                    ? AppColors.primaryBlue
                                    : AppColors.textDark,
                              ),
                              onPressed: () => setState(
                                  () => _isBookmarked = !_isBookmarked),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share_outlined, size: 20),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'See How the Forest is\nHelping Our World',
                      style: AppFonts.headerLarge,
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: AssetImage(AppAssets.avatar),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '\${widget.article.author} · \${widget.article.date}',
                          style: AppFonts.caption,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.article.content!,
                      style: AppFonts.bodyRegular
                          .copyWith(color: AppColors.textDark),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'One of the most important roles that forests play is in absorbing carbon dioxide from the atmosphere. Trees absorb carbon dioxide through photosynthesis and store it in their trunks, branches, and leaves.',
                      style: AppFonts.bodyRegular
                          .copyWith(color: AppColors.textDark),
                    ),
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
