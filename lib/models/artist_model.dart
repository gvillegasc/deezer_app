class ArtistModel {
  final int id;
  final String name;
  final String picture;
  final String tracklist;
  final bool selected;

  ArtistModel(
      {this.id,
      this.name,
      this.picture,
      this.tracklist,
      this.selected = false});

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
        id: json['id'],
        name: json['name'],
        picture: json['picture_big'],
        tracklist: json['tracklist']);
  }

  ArtistModel onSelected() {
    return ArtistModel(
        id: this.id,
        name: this.name,
        picture: this.picture,
        tracklist: this.tracklist,
        selected: !this.selected);
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
