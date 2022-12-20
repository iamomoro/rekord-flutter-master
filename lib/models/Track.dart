import 'package:flutter_rekord_app/models/Artist.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Media.dart';

part 'Track.g.dart';

@JsonSerializable(explicitToJson: true)
class Track {
  final int id;
  final String title;
  final String content;
  final String type;
  final String streamType;
  final String url;
  final Media media;
  final String postType;
  String localPath;
  final String time;
  final List<Artist> artist;
  Track(this.id, this.title, this.content, this.type, this.streamType, this.url,
      this.media, this.localPath, this.time, this.artist, this.postType);

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
