import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/explore_screen/data/models/article_model.dart';

class BookmarkStorage {
  static const String _key = 'saved_bookmarks';
  static const String _userKey = 'saved_user_name';

  // Notifier عام لتحديث واجهة البوك مارك فوراً في أي شاشة
  static final ValueNotifier<int> bookmarkUpdateNotifier =
      ValueNotifier<int>(0);

  static Future<List<ArticleModel>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((item) => ArticleModel.fromJson(jsonDecode(item))).toList();
  }

  static Future<bool> toggleBookmark(ArticleModel article) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getBookmarks();
    final index = list.indexWhere((item) => item.title == article.title);

    bool isNowBookmarked = false;
    if (index >= 0) {
      list.removeAt(index);
      isNowBookmarked = false;
    } else {
      list.add(article);
      isNowBookmarked = true;
    }

    final encoded = list.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_key, encoded);

    // إشعار جميع الشاشات بالتحديث
    bookmarkUpdateNotifier.value++;
    return isNowBookmarked;
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
    bookmarkUpdateNotifier.value++;
  }

  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, name);
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey) ?? 'Ahmed Saber';
  }
}
