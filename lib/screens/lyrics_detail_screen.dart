import 'package:flutter/material.dart';

class LyricsDetailScreen extends StatelessWidget {
  final String title;
  final String artist;
  final List<dynamic> lyrics;

  LyricsDetailScreen(
      {required this.title, required this.artist, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText(
                'Artist: $artist',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: lyrics
                      .map((ly) => SelectableText(
                            ly,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
