// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
    String? id;
    int? numberOfLikes;
    bool? didILikePost;
    String? username;
    bool? postBelongsToMe;
    DateTime timePosted;
    String? userId;
    String? postContent;

    PostModel({
        this.id,
        this.numberOfLikes,
        this.didILikePost,
        this.username,
        this.postBelongsToMe,
        required this.timePosted,
        this.userId,
        this.postContent,
    });

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["_id"],
        numberOfLikes: json["number_of_likes"],
        didILikePost: json["did_i_like_post"],
        username: json["username"],
        postBelongsToMe: json["post_belongs_to_me"],
        timePosted: DateTime.parse(json["time_posted"]),
        userId: json["user_id"],
        postContent: json["post_content"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "number_of_likes": numberOfLikes,
        "did_i_like_post": didILikePost,
        "username": username,
        "post_belongs_to_me": postBelongsToMe,
        "time_posted": timePosted.toIso8601String(),
        "user_id": userId,
        "post_content": postContent,
    };
}
