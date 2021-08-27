import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  final String songName;
  final String artistName;
  final double maxWidth;
  SongTile(
      {required this.songName,
      required this.artistName,
      required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        //height: height * 0.2,
        padding: EdgeInsets.all(15),
        constraints: BoxConstraints(
            minHeight: 200, minWidth: width * 0.5, maxWidth: maxWidth),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.black, blurRadius: 3, offset: Offset(1, 3))
            // ],
            gradient: LinearGradient(
                colors: [
                  //Colors.transparent,
                  Colors.blueGrey.withOpacity(0.1),
                  Colors.purple.withOpacity(0.8)
                ],
                // stops: [
                //   0.5,
                //   1
                // ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                artistName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
              ),
            ),
            Center(
              child: Text(
                songName,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
