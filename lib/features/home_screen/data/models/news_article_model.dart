class NewsArticleModel {
  final String id;
  final String title;
  final String category;
  final String author;
  final String date;
  final String imagePath;
  final String content;
  bool isBookmarked;

  NewsArticleModel({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.date,
    required this.imagePath,
    required this.content,
    this.isBookmarked = false,
  });
}
