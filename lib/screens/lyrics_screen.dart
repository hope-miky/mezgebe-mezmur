import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mezgebe_mezmur/providers/lyrics_provider.dart';
import 'package:mezgebe_mezmur/screens/components/topbar.dart';
import 'package:provider/provider.dart';
import 'lyrics_detail_screen.dart';
import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LyricsScreen extends StatefulWidget {
  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 3000),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

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
                  return Container(
                    margin: kIsWeb
                        ? EdgeInsets.symmetric(horizontal: screen.width * 0.2)
                        : EdgeInsets.zero,
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: lyricsProvider.lyrics.length,
                        itemBuilder: (context, index) {
                          var lyric = lyricsProvider.lyrics[index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Container(
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
                                    title: Text(
                                      lyric['title'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NotoSans',
                                      ),
                                    ),
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
                                        fontFamily: 'NotoSans',
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_right,
                                        color: Colors.grey[500]!),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            LyricsDetailScreen(
                                          title: lyric['title'],
                                          tags: lyric['tags'],
                                          artist: lyric['artist'],
                                          lyrics: lyric['lyrics'],
                                        ),
                                      ));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
