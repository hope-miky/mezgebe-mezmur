import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class LyricsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _lyrics = [];
  List<Map<String, dynamic>> get lyrics => _lyrics;
  final Box _favoritesBox = Hive.box('favorites');

  LyricsProvider() {
    fetchLyrics();
  }

  Future<void> fetchLyrics() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('mezmurs')
          .orderBy('id', descending: false)
          .get();
      _lyrics = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void filterLyrics(String query) async {
    if (query.isEmpty) {
      fetchLyrics();
    } else {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('mezmurs')
          .where(
            Filter.or(
              Filter.and(
                Filter("title", isGreaterThanOrEqualTo: query),
                Filter("title", isLessThanOrEqualTo: "${query}\uf7ff"),
              ),
              Filter("id", isEqualTo: query),
            ),
          )
          .orderBy('id', descending: false)
          .get();
      _lyrics = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("Search results: ${_lyrics}");
      notifyListeners();
    }
  }

  // Check if an item is marked as favorite
  bool isFavorite(String itemId) {
    return _favoritesBox.containsKey(itemId);
  }

  // Add an item to the favorite list
  void addFavorite(String itemId) {
    _favoritesBox.put(itemId, true);
    notifyListeners();
  }

  // Remove an item from the favorite list
  void removeFavorite(String itemId) {
    _favoritesBox.delete(itemId);
    notifyListeners();
  }

  // Toggle the favorite state
  void toggleFavorite(String itemId) {
    if (isFavorite(itemId)) {
      removeFavorite(itemId);
    } else {
      addFavorite(itemId);
    }
  }
}
