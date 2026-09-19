class ArticleModel {
  final String title;
  final String? description;
  final String? author;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? category;
  final String? id;
  final String? imagePath;
  final String? date;

  ArticleModel({
    required this.title,
    this.description,
    this.author,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.category,
    this.id,
    this.imagePath,
    this.date,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      author: json['author'] ?? 'Unknown Author',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] != null
          ? json['publishedAt'].toString().split('T').first
          : 'Recent',
      content: json['content'] ?? json['description'] ?? '',
      category: json['category'] ?? 'General',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'category': category,
      'id': id,
      'imagePath': imagePath,
      'date': date,
    };
  }
}
