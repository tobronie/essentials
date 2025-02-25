import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkProvider with ChangeNotifier {
  Map<String, List<String>> _bookmarks = {};

  Map<String, List<String>> get bookmarks => _bookmarks;

  Future<void> loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedBookmarks = prefs.getString('bookmarks');
    if (storedBookmarks != null) {
      _bookmarks = Map<String, List<String>>.from(
        json.decode(storedBookmarks).map(
              (key, value) => MapEntry(key, List<String>.from(value)),
            ),
      );
    }
    notifyListeners();
  }

  Future<void> addBookmark(String id_user, String idInfo) async {
    if (!_bookmarks.containsKey(id_user)) {
      _bookmarks[id_user] = [];
    }
    if (!_bookmarks[id_user]!.contains(idInfo)) {
      _bookmarks[id_user]!.add(idInfo);
      await _saveToPrefs();
      notifyListeners();
    }
  }

  Future<void> removeBookmark(String id_user, String idInfo) async {
    if (_bookmarks.containsKey(id_user) &&
        _bookmarks[id_user]!.contains(idInfo)) {
      _bookmarks[id_user]!.remove(idInfo);
      if (_bookmarks[id_user]!.isEmpty) {
        _bookmarks.remove(id_user);
      }
      await _saveToPrefs();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookmarks', json.encode(_bookmarks));
  }

  bool isBookmarked(String id_user, String idInfo) {
    return _bookmarks.containsKey(id_user) &&
        _bookmarks[id_user]!.contains(idInfo);
  }
}
