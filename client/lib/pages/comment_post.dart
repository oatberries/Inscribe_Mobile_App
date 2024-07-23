import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/components/top_bar.dart';
import 'package:inscribevs/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CommentPage extends StatefulWidget {
  final String postId;
  CommentPage({required this.postId, super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

 


class _CommentPageState extends State<CommentPage> {

late TextEditingController commentController;
List comments = [];
bool _isLoadingMore = false;
int _page = 1;
int _limit = 10;
bool isButtonActive = false;
 final ScrollController scrollController = ScrollController();
  
  void initState() {

    getComments();
    super.initState();
    scrollController.addListener(_scrollListener);
    commentController = TextEditingController();
    commentController.addListener(() {
      final isButtonActive = commentController.text.isNotEmpty;

      setState(() {
        this.isButtonActive = isButtonActive;
      });
    }); 
  }


  Future<void> _postComment() async{

    String URL = '${globals.base_url}/posts/${widget.postId}/comment';
    String comment = commentController.text.trim();

    final secureStorage = DataService.getInstance;
    String token = await secureStorage.read('token');

    final response = await http.post(
      Uri.parse(URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      },
      body:  json.encode(<String,dynamic> {
        "content" : "$comment",
      })
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      print("Successfully created post! : ${responseData}");
      var snackbar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Comment Added Successfully', 
            message: 'Comment has been added!', 
            contentType: ContentType.success
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        FocusManager.instance.primaryFocus?.unfocus();
    } else {
        print("Comment not created :C : ${response.body}");
      var snackbar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error', 
            message: 'Comment has not been created', 
            contentType: ContentType.failure
          ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

  }



  Future <void> getComments() async{
    
    String URL = "${globals.base_url}/posts/${widget.postId}/comments";
    
    final response = await http.get(Uri.parse("$URL?page=$_page&limit$_limit"),
    headers: {
      "Content-Type": "application/json",
      }
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      final commentData = responseData["data"];
      //comments = commentData["comments"];
      print("/n Response Data ${responseData} /n");
      print("/n Comments: ${comments} \n");
      //print("/n Comments ast position 0: ${comments[0]} ");
       setState(() {
          comments = comments + commentData["comments"];
         
        print("\n Post List: ${comments} \n");
        });
    }

  }

  Future <void> _scrollListener() async{
    if(_isLoadingMore) return;
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {

      print("call");
      setState(() {
        _isLoadingMore = true;
      });
      _page = _page + 1;
      await getComments();
      setState(() {
        _isLoadingMore = false;
      });

    } 
   }

 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 243, 220),
     appBar: TopBar(title: 'Comments'),
     body: Column(
       children: [
         Expanded(
           child: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Column(children: [
                
                  const SizedBox(height: 10),
                  
                
                  ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _isLoadingMore ? comments.length + 1 : comments.length,
                              itemBuilder: (_, index) {
                                if (index < comments.length) {
                                  return Card (
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  color: const Color.fromRGBO(183, 228, 199, 1),
                                  //margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: ListTile(
                                    title: Text(comments[index]["user"]["username"]),
                                    subtitle: Text(comments[index]["content"]),
                                    //tileColor: const Color.fromRGBO(183, 228, 199, 1),
                                  )
                                 );
                                } else {
                                  return Center(child: CircularProgressIndicator(),);
                                }
                              },
                              separatorBuilder: (context, index) => SizedBox(
                              height: 10, ),
                            ),
                ],),
              ),
           ),
         ),
         Container(
          color: Color.fromRGBO(8, 28, 21, 1),
          height: 50,
        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Container(
                  width: 275,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      label: Text('Add a comment') ,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    ),
                    controller: commentController,
                  ),
                ),
              ),

              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: isButtonActive ? () {
                    _postComment();
                    commentController.clear();
                  } : null,
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    disabledBackgroundColor: Colors.red,
                    //padding: EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // <-- Button color
                    foregroundColor: const Color.fromARGB(255, 224, 82, 72), // <-- Splash color
                  ),
                ),
              ),
            ],
          ),
         )
       ],
     ),
        
          
    );
  }
}