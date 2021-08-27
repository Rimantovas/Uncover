import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uncoverapp/Common/Common.dart';
import 'package:uncoverapp/MusicMatch.dart';

class RelatedPage extends StatefulWidget {
  @override
  _RelatedPageState createState() => _RelatedPageState();
}

class _RelatedPageState extends State<RelatedPage> {
  List<SongInfo> related = [];
  String name = "";
  List<SongInfo> topTracks = [];
  List<SongInfo> metalTracks = [];
  List<SongInfo> hiphopTracks = [];

  late SharedPreferences prefs;
  final controller = ScrollController();

  Future<void> fetchResults() async {
    prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('artists');
    //Top Tracks
    var result = await getTopTracks();
    if (mounted)
      setState(() {
        topTracks = result;
      });
    //Metal
    var metal = await getByMusicGenre("1153");
    if (mounted)
      setState(() {
        metalTracks = metal;
      });
    //HipHop
    var hiphop = await getByMusicGenre("1073");
    if (mounted)
      setState(() {
        hiphopTracks = hiphop;
      });

    if (list != null && list.isNotEmpty) {
      String random = list.elementAt(new Random().nextInt(list.length));
      await getArtistName(random).then((value) {
        if (mounted)
          setState(() {
            name = value;
          });
      });
      await getRelatedArtists(random).then((value) {
        if (mounted)
          setState(() {
            related = List.from(value);
          });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchResults();
    //getFavouriteArtists();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Good evening",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 30, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              if (topTracks.isNotEmpty)
                RelatedTile(text: "Top tracks", songs: topTracks),
              if (hiphopTracks.isNotEmpty)
                RelatedTile(text: "Hip-Hop", songs: hiphopTracks),
              if (metalTracks.isNotEmpty)
                RelatedTile(text: "Heavy metal", songs: metalTracks),
              if (related.isNotEmpty)
                RelatedTile(text: "Similar to $name", songs: related),
            ],
          ),
        ),
      ),
    );
  }
}
