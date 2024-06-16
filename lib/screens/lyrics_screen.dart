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
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(lyric['title']),
                          leading: Text(
                            '${lyric['id']}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            lyric['lyrics'][0],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              // Action for the more options button
                            },
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
                        ),
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
