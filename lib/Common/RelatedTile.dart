import 'package:flutter/material.dart';
import 'package:uncoverapp/Common/SongInfo.dart';
import 'package:uncoverapp/Common/TileList.dart';

class RelatedTile extends StatelessWidget {
  final String text;
  final List<SongInfo> songs;

  const RelatedTile({required this.text, required this.songs});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            width: width,
            height: height * 0.3,
            child: TileList(songs: songs, vertical: false),
          ),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}
