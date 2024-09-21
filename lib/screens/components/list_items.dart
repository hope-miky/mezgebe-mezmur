import 'package:flutter/material.dart';
import 'package:mezgebe_mezmur/providers/lyrics_provider.dart';
import 'package:mezgebe_mezmur/screens/lyrics_detail_screen.dart';

class AppMezmurListItem extends StatelessWidget {
  final lyric;
  final LyricsProvider lyricsProvider;

  const AppMezmurListItem(
      {super.key, required this.lyric, required this.lyricsProvider});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return ListTile(
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
        style: const TextStyle(
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
      trailing: SizedBox(
        width: screen.width * .25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            lyricsProvider.isFavorite('${lyric['id']}') == true
                ? IconButton(
                    iconSize: 15,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ))
                : Container(),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (String result) {
                var itm = lyric['id'].toString();
                if (result == 'add_to_favorite') {
                  if (lyricsProvider.isFavorite(itm) == true) {
                    lyricsProvider.removeFavorite(itm);
                  } else {
                    lyricsProvider.addFavorite(itm);
                  }
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'add_to_favorite',
                  child: Text('Add/Remove to favorite'),
                ),
                const PopupMenuItem<String>(
                  value: 'add_to_group',
                  child: Text('Add to a group'),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LyricsDetailScreen(
            id: lyric['id'].toString(),
            title: lyric['title'],
            tags: lyric['tags'],
            artist: lyric['artist'],
            lyrics: lyric['lyrics'],
          ),
        ));
      },
    );
  }
}
