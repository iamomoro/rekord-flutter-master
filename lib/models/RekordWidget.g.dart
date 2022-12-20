// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RekordWidget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RekordWidget _$RekordWidgetFromJson(Map<String, dynamic> json) {
  return RekordWidget(
    json['title'] as String,
    json['type'] as String,
    json['style'] as String,
    (json['tracks'] as List)
        ?.map(
            (e) => e == null ? null : Track.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['albums'] as List)
        ?.map(
            (e) => e == null ? null : Album.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : Artist.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RekordWidgetToJson(RekordWidget instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'style': instance.style,
      'tracks': instance.tracks?.map((e) => e?.toJson())?.toList(),
      'albums': instance.albums?.map((e) => e?.toJson())?.toList(),
      'artists': instance.artists?.map((e) => e?.toJson())?.toList(),
    };
