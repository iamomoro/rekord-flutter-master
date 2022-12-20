// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    json['id'] as int,
    json['content'] as String,
    json['date'] as String,
    json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>),
    json['approved'] as bool,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'date': instance.date,
      'author': instance.author?.toJson(),
      'approved': instance.approved,
    };
