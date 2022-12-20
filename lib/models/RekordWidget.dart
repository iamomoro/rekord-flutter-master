import 'package:flutter_rekord_app/models/Artist.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Album.dart';

import 'Track.dart';

part 'RekordWidget.g.dart';

@JsonSerializable(explicitToJson: true)
class RekordWidget {
  String title;
  String type;

  String style;
  List<Track> tracks;
  List<Album> albums;
  List<Artist> artists;
  RekordWidget(this.title, this.type, this.style, this.tracks, this.albums,
      this.artists);
  factory RekordWidget.fromJson(Map<String, dynamic> json) =>
      _$RekordWidgetFromJson(json);

  Map<String, dynamic> toJson() => _$RekordWidgetToJson(this);
}
