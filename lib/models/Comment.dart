import 'package:flutter_rekord_app/models/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment {
  final int id;
  final String content;
  final String date;
  final User author;
  final bool approved;

  Comment(
    this.id,
    this.content,
    this.date,
    this.author,
    this.approved,
  );
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
