// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['id'] as int,
    json['title'] as String,
    json['content'] as String,
    json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>),
    json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
    (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['date'] as String,
    json['commentCount'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'media': instance.media?.toJson(),
      'author': instance.author?.toJson(),
      'date': instance.date,
      'comments': instance.comments?.map((e) => e?.toJson())?.toList(),
      'commentCount': instance.commentCount,
    };
