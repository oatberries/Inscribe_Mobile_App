import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:like_button/like_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LikeButtonWidget extends StatefulWidget {
 final bool isLiked;
 final int likeCount;
 final postId;

  const LikeButtonWidget({required this.isLiked, required this.likeCount, required this.postId, super.key});

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {

  Future<void> LikeSetter(bool liked) async {
    DataService secureStorage = DataService.getInstance;
    String token = await secureStorage.read('token');
    

    if (liked == false) {
      const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/like-post';
      var response = await http.post(
        Uri.parse(URL),
        headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
        },
        body: json.encode(<String,dynamic> {
        "postId" : '${widget.postId}'
      }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("/n Sucessfully liked post! ${responseData}");
      }
      else {
        print(" liked post no successful! ${response.body}");
      }
      
    } else {
      const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/unlike-post';

      var response = await http.post(
        Uri.parse(URL),
        headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
        }, 
        body: json.encode(<String,dynamic> {
        'postId' : '${widget.postId}'
        }),
      );

      if (response.statusCode == 200) {
        var responseData = utf8.decode(response.bodyBytes);
        print("/n Sucessfully unliked post! ${responseData}");
      }
      else {
        var responseData = utf8.decode(response.bodyBytes);
        print("/n unliked post no successful! ${responseData}");
      }

    }
    
  }
  // bool isLiked = this.isLiked;
  @override
  Widget build(BuildContext context) {
    bool isLike = widget.isLiked;
    int likeCounter = widget.likeCount;
    return  LikeButton(
      size: 40,
      isLiked: widget.isLiked,
      likeCount: widget.likeCount,
      likeBuilder: (isLiked) {
        final color = isLiked? Colors.red : Colors.grey;
        return Icon(Icons.favorite, color: color, size: 20);
      },
      countBuilder: (count, isLiked, text) {
        final color = isLiked? Colors.black : Colors.grey;
        return Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold));
      },
      onTap: (isLiked) async {

       // serverRequest
      


      LikeSetter(isLiked);
      isLike = !isLiked;

        
        likeCounter += isLiked ? 1 : - 1;

        return !isLiked;

      },
    );
  }
}