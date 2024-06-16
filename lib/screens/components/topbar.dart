// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mezgebe_mezmur/providers/lyrics_provider.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width,
      height: screen.height * 0.3,
      padding: EdgeInsets.only(
        top: 70,
        left: 24,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFF452E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mezgebe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Text(
            'Mezmur',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screen.width * 0.06),
            child: SizedBox(
              width: screen.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screen.width * 0.8,
                    child: TextField(
                      decoration: InputDecoration(
                        label: Text('Search'),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        Provider.of<LyricsProvider>(context, listen: false)
                            .filterLyrics(value);
                      },
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   color: Colors.white,
                  //   icon: Icon(Icons.filter_list),
                  //   iconSize: 34,
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
