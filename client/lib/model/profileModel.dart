import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String? first_name;
  String? last_name;
  String? username;
  String?  email;
  String?  bio;
  String? profile_image;
  DateTime ? created_at;

  ProfileModel ({
    this.first_name,
    this.last_name,
    this.username,
    this.email,
    this.bio,
    this.profile_image = '',
    this.created_at,
    });

    factory ProfileModel.fromJson(Map<String,dynamic> json) => _$ProfileModelFromJson(json);

    Map<String,dynamic> toJson() => _$ProfileModelToJson(this);
}
