import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'user_id')
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final bool? emailVerified;
  final String? password;
  final String? locate;
  @JsonKey(name: 'image_url')
  final String? photoUrl;

  const UserModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.emailVerified,
    this.password,
    this.locate,
    this.photoUrl,
  });
  UserModel copyWith(
      {String? uid,
      String? name,
      String? email,
      String? phoneNumber,
      bool? emailVerified,
      String? password,
      String? locate,
      String? photoUrl}) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailVerified: emailVerified ?? this.emailVerified,
      password: password ?? this.password,
      locate: locate ?? this.locate,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory UserModel.fromFirebaseUser(User? user) {
    return UserModel(
      name: user?.displayName ?? '',
      email: user?.email ?? '',
      uid: user?.uid,
      phoneNumber: user?.phoneNumber ?? '',
      emailVerified: user?.emailVerified,
      photoUrl: user?.photoURL ?? '',
    );
  }
}
