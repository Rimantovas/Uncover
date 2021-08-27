import 'package:flutter/material.dart';
import 'package:uncoverapp/Common/Common.dart';
import 'package:uncoverapp/LyricsFetch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsPage extends StatefulWidget {
  final SongInfo info;
  DetailsPage({required this.info});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String lyrics = "";

  late SharedPreferences prefs;

  Future<void> fetchLyrics() async {
    prefs = await SharedPreferences.getInstance();
    var list = (prefs.getStringList('artists') ?? []);
    if (!list.contains(widget.info.artistID)) list.add(widget.info.artistID);

    await prefs.setStringList('artists', list);
    if (list.length > 5) prefs.clear();

    String result =
        await getLyrics(track: widget.info.song, artist: widget.info.artist);
    if (mounted)
      setState(() {
        lyrics = result;
      });
  }

  @override
  void initState() {
    fetchLyrics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Stack(clipBehavior: Clip.none, children: [
              Hero(
                tag: widget.info.songID,
                child: SongTile(
                  songName: widget.info.song,
                  artistName: widget.info.artist,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                bottom: -5,
                right: 7,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(3, 3),
                        blurRadius: 5)
                  ], shape: BoxShape.circle, color: Colors.purple),
                  child: Center(
                    child: Text(
                      widget.info.songRating,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ]),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: lyrics.length != 0
                          ? Text(
                              lyrics,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            )
                          : CircularProgressIndicator()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
