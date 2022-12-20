// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    json['id'] as int,
    json['title'] as String,
    json['content'] as String,
    json['type'] as String,
    json['streamType'] as String,
    json['url'] as String,
    json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
    json['localPath'] as String,
    json['time'] as String,
    (json['artist'] as List)
        ?.map((e) =>
            e == null ? null : Artist.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['postType'] as String,
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'type': instance.type,
      'streamType': instance.streamType,
      'url': instance.url,
      'media': instance.media?.toJson(),
      'postType': instance.postType,
      'localPath': instance.localPath,
      'time': instance.time,
      'artist': instance.artist?.map((e) => e?.toJson())?.toList(),
    };
