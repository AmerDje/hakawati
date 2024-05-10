// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['user_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      password: json['password'] as String?,
      emailVerified: json['email_verified'] as bool?,
      locate: json['locate'] as String?,
      photoUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$UserToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
      'email_verified': instance.emailVerified,
      'locate': instance.locate,
      'image_url': instance.photoUrl,
    };
