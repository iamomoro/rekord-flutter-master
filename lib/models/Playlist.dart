import 'package:flutter_rekord_app/models/Track.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Media.dart';
part 'Playlist.g.dart';

@JsonSerializable(explicitToJson: true)
class Playlist {
  int id;
  String title;
  String content;
  Media media;
  List<Track> tracks;

  Playlist(this.id, this.title, this.content, this.media, this.tracks);
  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
