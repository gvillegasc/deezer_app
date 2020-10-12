import 'package:deezer_app/models/track_model.dart';

class ArtistModel {
  final int id;
  final String name;
  final String picture;
  final String tracklist;
  final bool selected;
  final List<TrackModel> tracks;

  ArtistModel(
      {this.id,
      this.name,
      this.picture,
      this.tracklist,
      this.selected = false,
      this.tracks = const []});

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    List<TrackModel> tracks = [];
    if (json['tracks'] != null) {
      tracks = (json['tracks'] as List)
          .map<TrackModel>((e) => TrackModel.fromJson(e))
          .toList();
    }
    return ArtistModel(
        id: json['id'],
        name: json['name'],
        picture: json['picture_big'],
        tracklist: json['tracklist'],
        tracks: tracks);
  }

  ArtistModel onSelected() {
    return ArtistModel(
        id: this.id,
        name: this.name,
        picture: this.picture,
        tracklist: this.tracklist,
        selected: !this.selected,
        tracks: this.tracks);
  }

  ArtistModel addTracks(List<TrackModel> tracks) {
    return ArtistModel(
        id: this.id,
        name: this.name,
        picture: this.picture,
        tracklist: this.tracklist,
        selected: this.selected,
        tracks: tracks);
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> tracks =
        this.tracks.map((e) => e.toJson()).toList();

    return {
      "id": this.id,
      "name": this.name,
      "picture_big": this.picture,
      "tracklist": this.tracklist,
      "tracks": tracks
    };
  }
}
