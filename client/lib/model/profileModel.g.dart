// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      bio: json['bio'] as String? ?? '',
      verified: json['verified'] as bool?,
      following_count: (json['following_count'] as num?)?.toInt(),
      follower_count: (json['follower_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'username': instance.username,
      'email': instance.email,
      'bio': instance.bio,
      'verified': instance.verified,
      'following_count': instance.following_count,
      'follower_count': instance.follower_count,
    };
