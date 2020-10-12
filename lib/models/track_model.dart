class TrackModel {
  final int id;
  final String title;
  final int duration;
  final int rank;
  final String preview;
  final AlbumModel album;

  TrackModel(
      {this.id,
      this.title,
      this.duration,
      this.rank,
      this.preview,
      this.album});

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
        id: json['id'],
        title: json['title'],
        duration: json['duration'],
        rank: json['rank'],
        preview: json['preview'],
        album: AlbumModel.fromJson(json['album']));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "duration": this.duration,
      "rank": this.rank,
      "title": this.title,
      "preview": this.preview,
      "album": this.album.toJson()
    };
  }
}

class AlbumModel {
  final int id;
  final String title;
  final String cover;
  final String tracklist;

  AlbumModel({this.id, this.title, this.cover, this.tracklist});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "cover_big": this.cover,
      "tracklist": this.tracklist,
    };
  }

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      title: json['title'],
      cover: json['cover_big'],
      tracklist: json['tracklist'],
    );
  }
}
