import 'package:flutter/material.dart';
import 'package:uncoverapp/Common/SongInfo.dart';
import 'package:uncoverapp/Common/SongTile.dart';
import 'package:uncoverapp/Screens/DetailsPage.dart';

class TileList extends StatelessWidget {
  final List<SongInfo> songs;
  final bool vertical;
  TileList({required this.songs, required this.vertical});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        itemCount: songs.length,
        scrollDirection: vertical ? Axis.vertical : Axis.horizontal,
        itemBuilder: (context, item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: Stack(
              children: [
                Hero(
                  tag: songs[item].songID,
                  child: SongTile(
                    songName: songs[item].song,
                    artistName: songs[item].artist,
                    maxWidth: vertical ? width : width * 0.6,
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DetailsPage(info: songs[item])));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
