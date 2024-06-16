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
      height: screen.height * 0.25,
      padding: EdgeInsets.only(
        top: 75,
        left: 20,
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
                'Wellcome to',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Text(
            'Mezgebe Mezmur',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screen.width * 0.04),
            child: SizedBox(
              width: screen.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screen.width * 0.85,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by key-words',
                        prefixIcon: Icon(Icons.search),
                        fillColor: Colors.grey[200],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        ),
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
