class ArtistModel {
  final int id;
  final String name;
  final String picture;
  final String tracklist;

  ArtistModel({this.id, this.name, this.picture, this.tracklist});

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
        id: json['id'],
        name: json['name'],
        picture: json['picture_big'],
        tracklist: json['tracklist']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "picture_big": this.picture,
      "tracklist": this.tracklist,
    };
  }
}
