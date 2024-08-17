import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:share_plus/share_plus.dart';

class LyricsDetailScreen extends StatelessWidget {
  final String title;
  final String artist;
  final List<dynamic> lyrics;
  final List<dynamic> tags;

  LyricsDetailScreen({
    required this.title,
    required this.artist,
    required this.lyrics,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    String prepareData() {
      var content = '';
      for (var el in lyrics) {
        content += '\n $el';
      }
      return "Zemari: $artist \n Title: $title \n ----- $content  ";
    }

    return Scaffold(
      appBar: AppBar(
        title: SelectableText(
          title,
          style: TextStyle(
            fontFamily: 'NotoSans',
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              // Copy the lyrics to the clipboard
              Clipboard.setData(ClipboardData(text: prepareData()));

              // Show a SnackBar to notify the user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mezmur copied to clipboard!')),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                // Share the lyrics using the share_plus package
                Share.share(prepareData());
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText(
                'Zemari: $artist',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSans',
                ),
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
                              fontSize: 18,
                              fontFamily: 'NotoSans',
                            ),
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screen.height * .05),
                child: SizedBox(
                  width: screen.width,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: tags
                        .map((_tag) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "#$_tag",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ))
                        .toList() as List<Widget>,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
