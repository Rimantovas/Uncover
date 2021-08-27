import 'package:flutter/material.dart';
import 'package:uncoverapp/Common/Common.dart';
import 'package:uncoverapp/MusicMatch.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool searching = false;
  final _search = TextEditingController();
  List<SongInfo> songs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[800],
          centerTitle: true,
          title: SearchBar(
              controller: _search,
              hintText: "Search...",
              function: () async {
                setState(() {
                  searching = true;
                });
                FocusManager.instance.primaryFocus?.unfocus();
                List<SongInfo> list = await getArtistSongs(_search.text);
                setState(() {
                  searching = false;
                  songs = new List.from(list);
                });
              })),
      body: Column(
        children: [
          if (searching)
            LinearProgressIndicator(
              backgroundColor: Colors.white,
            ),
          songs.length != 0 && !searching
              ? Expanded(
                  child: Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25, bottom: 10),
                  child: TileList(
                    songs: songs,
                    vertical: true,
                  ),
                ))
              : Expanded(child: Center(child: Text("Not found")))
        ],
      ),
    );
  }
}
