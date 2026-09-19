import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/explore_screen/data/models/article_model.dart';

class BookmarkStorage {
  static const String _key = 'saved_bookmarks';

  static Future<List<ArticleModel>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((item) => ArticleModel.fromJson(jsonDecode(item))).toList();
  }

  static Future<void> toggleBookmark(ArticleModel article) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getBookmarks();
    final index = list.indexWhere((item) => item.title == article.title);

    if (index >= 0) {
      list.removeAt(index);
    } else {
      list.add(article);
    }

    final encoded = list.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  static Future<bool> isBookmarked(String title) async {
    final list = await getBookmarks();
    return list.any((item) => item.title == title);
  }

  static Future<void> removeBookmark(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getBookmarks();
    list.removeWhere((item) => item.title == title);
    final encoded = list.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }
}
