import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'User.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final String token;
  final String displayName;

  User({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.token,
    this.displayName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
