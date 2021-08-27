import 'package:http/http.dart' as http;

final String _url =
    "https://www.google.com/search?client=safari&rls=en&ie=UTF-8&oe=UTF-8&q=";
String _delimiter1 =
    '</div></div></div></div><div class="hwc"><div class="BNeawe tAd8D AP7Wnd"><div><div class="BNeawe tAd8D AP7Wnd">';
String _delimiter2 =
    '</div></div></div></div></div><div><span class="hwc"><div class="BNeawe uEec3 AP7Wnd">';

Future<String> getLyrics(
    {required String track, required String artist}) async {
  String lyrics;
  try {
    lyrics = (await http
            .get(Uri.parse(Uri.encodeFull('$_url$track by $artist lyrics'))))
        .body;
    lyrics = lyrics.split(_delimiter1).last;
    lyrics = lyrics.split(_delimiter2).first;
    if (lyrics.indexOf('<meta charset="UTF-8">') > -1) throw Error();
  } catch (_) {
    try {
      lyrics = (await http.get(
              Uri.parse(Uri.encodeFull('$_url$track by $artist song lyrics'))))
          .body;
      lyrics = lyrics.split(_delimiter1).last;
      lyrics = lyrics.split(_delimiter2).first;
      if (lyrics.indexOf('<meta charset="UTF-8">') > -1) throw Error();
    } catch (_) {
      try {
        lyrics = (await http.get(Uri.parse(Uri.encodeFull(
                '$_url${track.split("-").first} by $artist lyrics'))))
            .body;
        lyrics = lyrics.split(_delimiter1).last;
        lyrics = lyrics.split(_delimiter2).first;
        if (lyrics.indexOf('<meta charset="UTF-8">') > -1) throw Error();
      } catch (_) {
        // give up
        return "No lyrics found";
      }
    }
  }
  final List<String> split = lyrics.split('\n');
  String result = '';
  for (var i = 0; i < split.length; i++) {
    result = '$result${split[i]}\n';
  }
  return result.trim();
}
