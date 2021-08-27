class SongInfo {
  final String artistID;
  final String songID;
  final String song;
  final String songRating;
  final String artist;

  @override
  bool operator ==(Object other) {
    return other is SongInfo && other.song == this.song;
  }

  @override
  int get hashCode => super.hashCode;

  SongInfo({
    required this.songRating,
    required this.artistID,
    required this.songID,
    required this.song,
    required this.artist,
  });
}
