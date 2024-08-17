import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LyricsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _lyrics = [];
  List<Map<String, dynamic>> get lyrics => _lyrics;

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
}
