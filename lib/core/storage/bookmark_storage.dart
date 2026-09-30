import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/explore_screen/data/models/article_model.dart';

/// Saves bookmarked articles on the device.
class BookmarkStorage {
  static const String _key = 'saved_bookmarks';

  /// Increases every time bookmarks change, so any screen can refresh itself.
  static final ValueNotifier<int> bookmarkUpdateNotifier = ValueNotifier<int>(0);

  static Future<List<ArticleModel>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data
        .map((item) => ArticleModel.fromJson(jsonDecode(item)))
        .toList();
  }

  static Future<bool> isBookmarked(ArticleModel article) async {
    final list = await getBookmarks();
    return list.any((item) => item.key == article.key);
  }

  /// Adds the article if missing, removes it if saved. Returns the new state.
  static Future<bool> toggleBookmark(ArticleModel article) async {
    final list = await getBookmarks();
    final index = list.indexWhere((item) => item.key == article.key);

    if (index >= 0) {
      list.removeAt(index);
    } else {
      list.insert(0, article);
    }
    await _save(list);
    return index < 0;
  }

  static Future<void> removeBookmark(ArticleModel article) async {
    final list = await getBookmarks();
    list.removeWhere((item) => item.key == article.key);
    await _save(list);
  }

  static Future<void> _save(List<ArticleModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = list.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_key, encoded);
    bookmarkUpdateNotifier.value++;
  }
}
