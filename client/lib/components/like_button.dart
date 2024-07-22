import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:like_button/like_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscribevs/globals.dart' as globals;

class LikeButtonWidget extends StatefulWidget {
 final int likeCount;
 final postId;

  LikeButtonWidget({required this.likeCount, required this.postId, super.key});

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {

  //bool hasLiked = false;

  Future<void> LikeSetter(bool liked) async {
    DataService secureStorage = DataService.getInstance;
    String token = await secureStorage.read('token');
    

    if (liked == false) {
      String URL = '${globals.base_url}/posts/${widget.postId}/like';
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
        // setState(() {
        //   hasLiked = true;
        // });
      }
      else {
        print(" liked post no successful! ${response.body}");
      }
      
    } else {
       String URL = '${globals.base_url}/posts/${widget.postId}/unlike';

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
        //  setState(() {
        //   hasLiked = false;
        // });
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
    bool isLike = false;
    int likeCounter = widget.likeCount;
    return  LikeButton(
      size: 40,
      isLiked: isLike,
      likeCount: widget.likeCount,
      likeBuilder: (isLiked) {
        final color = isLiked ? Colors.red : Colors.grey;
        return Icon(Icons.favorite, color: color, size: 20);
      },
      countBuilder: (count, isLiked, text) {
        final color = isLiked? Colors.black : Colors.grey;
        return Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold));
      },
      onTap: (isLiked) async {
       
       
        isLike = !isLiked;
        likeCounter += isLike? 1 : - 1;

       LikeSetter(isLiked);

        return isLike;

      },
    );
  }
}