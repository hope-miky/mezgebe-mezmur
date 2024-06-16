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
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('mezmurs').get();
      _lyrics = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void filterLyrics(String query) {
    if (query.isEmpty) {
      fetchLyrics();
    } else {
      _lyrics = _lyrics
          .where((lyric) => lyric['title'].contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
}
