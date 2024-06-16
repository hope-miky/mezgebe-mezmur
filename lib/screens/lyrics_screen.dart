import 'package:flutter/material.dart';
import 'package:mezgebe_mezmur/providers/lyrics_provider.dart';
import 'package:mezgebe_mezmur/screens/components/topbar.dart';
import 'package:provider/provider.dart';
import 'lyrics_detail_screen.dart';

class LyricsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          Expanded(
            child: Consumer<LyricsProvider>(
              builder: (context, lyricsProvider, child) {
                if (lyricsProvider.lyrics.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: lyricsProvider.lyrics.length,
                    itemBuilder: (context, index) {
                      var lyric = lyricsProvider.lyrics[index];
                      return ListTile(
                        title: Text(lyric['title']),
                        subtitle: Text(
                          lyric['lyrics'][0],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LyricsDetailScreen(
                              title: lyric['title'],
                              artist: lyric['artist'],
                              lyrics: lyric['lyrics'],
                            ),
                          ));
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
