import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String? first_name;
  String? last_name;
  String? username;
  String?  email;
  String?  bio;
  bool? verified;
  int? following_count;
  int? follower_count;
  ProfileModel ({
    this.first_name,
    this.last_name,
    this.username,
    this.email,
    this.bio,
    this.verified,
    this.following_count,
    this.follower_count});

    factory ProfileModel.fromJson(Map<String,dynamic> json) => _$ProfileModelFromJson(json);

    Map<String,dynamic> toJson() => _$ProfileModelToJson(this);
}
