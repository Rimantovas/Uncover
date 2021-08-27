import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uncoverapp/Common/Common.dart';
import 'package:uncoverapp/api_key.dart';

Future<List<SongInfo>> getTopTracks() async {
  try {
    List<SongInfo> list = [];
    final String url =
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?chart_name=top&page=1&page_size=10&apikey=$privateKey";

    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    var convertToJson = jsonDecode(response.body);
    for (var track in convertToJson['message']['body']['track_list']) {
      list.add(new SongInfo(
        songRating: track['track']['track_rating'].toString(),
        song: track['track']['track_name'].toString(),
        artist: track['track']['artist_name'].toString(),
        songID: track['track']['track_id'].toString(),
        artistID: track['track']['artist_id'].toString(),
      ));
    }
    return list.toSet().toList();
  } catch (e) {
    return [];
  }
}

Future<List<SongInfo>> getArtistSongs(String search) async {
  try {
    if (search.trim().length != 0) {
      List<SongInfo> list = [];
      final String url =
          "http://api.musixmatch.com/ws/1.1/track.search?q_track_artist=$search&page_size=10&page=1&s_track_rating=desc&apikey=$privateKey";

      var response = await http
          .get(Uri.parse(url), headers: {"Accept": "application/json"});

      var convertToJson = jsonDecode(response.body);

      for (var track in convertToJson['message']['body']['track_list']) {
        var result = new SongInfo(
          songRating: track['track']['track_rating'].toString(),
          song: track['track']['track_name'].toString(),
          artist: track['track']['artist_name'].toString(),
          songID: track['track']['track_id'].toString(),
          artistID: track['track']['artist_id'].toString(),
        );
        if (!list.contains(result)) list.add(result);
      }
      return list;
    }
    return [];
  } catch (e) {
    return [];
  }
}

Future<List<SongInfo>> getRelatedArtists(String artistID) async {
  try {
    List<SongInfo> list = [];
    final String url =
        "http://api.musixmatch.com/ws/1.1/artist.related.get?artist_id=$artistID&page_size=6&page=1&apikey=$privateKey";

    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    var convertToJson = jsonDecode(response.body);

    for (var track in convertToJson['message']['body']['artist_list']) {
      String artistid = track['artist']['artist_id'].toString();
      await getArtistTopTrack(artistid).then((value) {
        if (value.isNotEmpty) {
          list.add(new SongInfo(
            songRating: track['artist']['artist_rating'].toString(),
            song: value[0],
            artist: track['artist']['artist_name'].toString(),
            songID: value[1],
            artistID: artistid,
          ));
        }
      });
    }
    return list.toSet().toList();
  } catch (e) {
    return [];
  }
}

Future<String> getArtistName(String artistID) async {
  try {
    final String url =
        "http://api.musixmatch.com/ws/1.1/artist.get?artist_id=$artistID&apikey=$privateKey";

    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    var convertToJson = jsonDecode(response.body);

    return convertToJson['message']['body']['artist']['artist_name'];
  } catch (e) {
    return "";
  }
}

Future<List<String>> getArtistTopTrack(String artistID) async {
  try {
    final String url =
        "http://api.musixmatch.com/ws/1.1/track.search?f_artist_id=$artistID&page_size=10&page=1&s_track_rating=desc&apikey=$privateKey";

    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    List<String> list = [];

    var convertToJson = jsonDecode(response.body);
    for (var track in convertToJson['message']['body']['track_list']) {
      return [
        track['track']['track_name'].toString(),
        track['track']['track_id'].toString()
      ];
    }
    return list;
  } catch (e) {
    return [];
  }
}

Future<List<SongInfo>> getByMusicGenre(String genreID) async {
  try {
    List<SongInfo> list = [];
    final String url =
        "http://api.musixmatch.com/ws/1.1/track.search?f_music_genre_id=$genreID&page_size=10&page=1&s_track_rating=desc&apikey=$privateKey";

    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    var convertToJson = jsonDecode(response.body);

    for (var track in convertToJson['message']['body']['track_list']) {
      var result = new SongInfo(
        songRating: track['track']['track_rating'].toString(),
        song: track['track']['track_name'].toString(),
        artist: track['track']['artist_name'].toString(),
        songID: track['track']['track_id'].toString(),
        artistID: track['track']['artist_id'].toString(),
      );

      if (!list.contains(result)) list.add(result);
    }
    return list;
  } catch (e) {
    List<SongInfo> list = [];
    return list;
  }
}
