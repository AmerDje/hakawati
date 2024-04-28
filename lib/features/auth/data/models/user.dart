import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'user_id')
  final String? userId;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  User({
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
