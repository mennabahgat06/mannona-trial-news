/// One article from NewsAPI ("everything" / "top-headlines").
class ArticleModel {
  final String title;
  final String? description;
  final String? author;
  final String? sourceName;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  ArticleModel({
    required this.title,
    this.description,
    this.author,
    this.sourceName,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  /// Unique key used for bookmarks.
  String get key => (url != null && url!.isNotEmpty) ? url! : title;

  /// Author name, or the news source, or "Unknown".
  String get writer {
    if (author != null && author!.isNotEmpty) return author!;
    if (sourceName != null && sourceName!.isNotEmpty) return sourceName!;
    return 'Unknown';
  }

  /// Full text to show on the details screen.
  /// NewsAPI cuts "content" and adds "[+1234 chars]" at the end, so we remove it.
  String get body {
    final text = (content != null && content!.isNotEmpty)
        ? content!
        : (description ?? '');
    final cleaned = text.replaceAll(RegExp(r'\s*\[\+\d+ chars\]$'), '');
    return cleaned.isEmpty ? 'No content available.' : cleaned;
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final source = json['source'];
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      description: json['description'],
      author: json['author'],
      sourceName: source is Map ? source['name'] : json['sourceName'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'sourceName': sourceName,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
