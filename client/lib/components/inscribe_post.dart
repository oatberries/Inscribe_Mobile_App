import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/components/like_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:inscribevs/pages/edit_post.dart';
import 'package:inscribevs/globals.dart' as globals;

class InscribePost extends StatefulWidget {
  final Function updateStartPage;
  final String username;
  final String post_content;
  final int num_of_likes;
  //final bool did_i_like_post;
  final postId;
  //final String userId;

  InscribePost({required this.updateStartPage, required this.username,required this.post_content,required this.num_of_likes,required this.postId,super.key});

  @override
  State<InscribePost> createState() => _InscribePostState();
}

class _InscribePostState extends State<InscribePost> {
  @override
  Widget build(BuildContext context) {

    Future<void> _deletePost() async{

    DataService secureStorage = DataService.getInstance;
    String token = await secureStorage.read('token');

      String URL = '${globals.base_url}/posts/${widget.postId}';

    var response = await http.delete(
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
        print("Successfully deleted post! : ${responseData}");
        Navigator.of(context).pop();
        
      } else {
        print("Unable to delete post : ${response.body}");
      }
    }
    
    return Container(
       
        width: 330,
        decoration: BoxDecoration( 
          color: Color.fromRGBO(183, 228, 199, 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
      
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text( '${widget.username}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            IconButton(
              // Open bottom sheet menu
              onPressed: () {
                showModalBottomSheet(
                  context: context, 
                  builder: (BuildContext context) {
                    return Container(
                      
                      height: 200,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(children: [
                                
                              SizedBox(
                                width: 275,
                                child: ElevatedButton.icon(
                                  // Edit Post
                                  onPressed: () {
                                   showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Text('Delete Post Confirmation'),
                                        content: Text('Are you sure you want to delete your post? This action is irreversible.'),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel', style: TextStyle(color: Colors.red),),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                            // async method    
                                            _deletePost();
                                              Navigator.of(context).pop();
                                              widget.updateStartPage();
                                            },
                                            child: Text('Delete',style: TextStyle(color: Colors.blue)),
                                          )
                                        ],
                                      );

                                     });
                                  },
                                  icon: Icon(Icons.delete_forever), 
                                  label: Text('Delete'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white70
                                  )
                                  ),
                              ),
                          
                                SizedBox(
                                  width: 275,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, 
                                    child: Text('Close'),
                                    style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white70
                                  )
                                    
                                    ),
                                )
                          ],),
                        ),
                      ),
                    );
                  });
              }, 
              icon: Icon(Icons.more_horiz)
              )
          ],
        ),
        const SizedBox(height: 7),
        Text('${widget.post_content}',
        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300)),
        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           
            LikeButtonWidget(likeCount: widget.num_of_likes, postId: widget.postId,),
            const SizedBox(width: 10),
            IconButton(
              // Go to PostPage Comments
              onPressed: () {

              },
            alignment: Alignment.topCenter,
            icon: Icon(Icons.comment, size: 22,)),
        ],)
    
      ],
    ),
  ),
    );
  }
}

