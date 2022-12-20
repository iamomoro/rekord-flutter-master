import 'package:flutter_rekord_app/models/Track.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Media.dart';
part 'Album.g.dart';

@JsonSerializable(explicitToJson: true)
class Album {
  final int id;
  final String title;
  final String content;
  final Media media;
  final List<Track> tracks;

  Album(this.id, this.title, this.content, this.media, this.tracks);
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
