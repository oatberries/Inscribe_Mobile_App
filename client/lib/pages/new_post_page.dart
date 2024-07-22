
import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscribevs/globals.dart' as globals;

class NewPostPage extends StatefulWidget {
  
  const NewPostPage({super.key});
  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {

  final secureStorage = DataService.getInstance;
  String content = '';
   
  
  Future <void> _createNewPost() async{

    String myToken = await secureStorage.read('token');
    String URL = '${globals.base_url}/post';


    final response = await http.post(
      Uri.parse(URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $myToken"
      },
      body: json.encode(<String,dynamic> {
        'content' : '$content'
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      Navigator.of(context).pop();
      print('New Post Created Successfully: ${responseData}');
      var snackbar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'New Post Created', 
            message: 'Post has been created successfully', 
            contentType: ContentType.success
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);

    } else {
      print('Registration failed: ${responseData}');
      var snackbar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error', 
            message: responseData['message'], 
            contentType: ContentType.failure
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  @override
  Widget build(BuildContext context) { 
  
    // Display warning upon tapping the exit button
    Future <bool?> _showBackDialog() {
      return showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('You will lose your post content if you leave this page.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context,false);
                }, 
                child: const Text('Cancel')
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context,true);
                }, 
                child: const Text('Leave')
              )
            ],
          );
      } 
      );
    }
    final _controller = QuillController.basic();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(216, 243, 220,1),
      // App bar
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(216, 243, 220,1),
        // Bottom Border of App Bar
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black26, 
            width: 1,
          )
        ),

        // Title of New Post Page
        title: const Text(
          'Create a New Post',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,

        // Post Page Button
        actions: <Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              width: 60,
              child: MaterialButton(
                // Verify and Create Post Page
                onPressed: () {
                  String postContent = _controller.document.toPlainText().trim();
                  if (!postContent.isEmpty && postContent.length < 250) {
                    print(postContent);
                    content = _controller.document.toPlainText().trim();
                    _createNewPost();
                  } else {
                    // display errors
                    print("error");
                     var snackbar;
                    if (postContent.isEmpty || postContent.length == 0)
                    {
                      snackbar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Error', 
                          message: 'Post content field cannot be empty.', 
                          contentType: ContentType.failure
                          ),
                        );
                    } else {

                      snackbar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Error', 
                          message: 'Post content cannot exceed 255 characters', 
                          contentType: ContentType.failure
                          ),
                        );

                    }
                     ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                color: const Color.fromRGBO(82, 183, 136, 1),
                shape:const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13
                  ),
                ),
              ),
            ),
          )
        ],

        // Cancel Button
        leading: PopScope(
          canPop: false,
          onPopInvoked: ((bool didPop) async {
            if (didPop) {
              return;
            }
            final bool shouldPop = await _showBackDialog() ?? false;
            if (context.mounted  && shouldPop) {
              Navigator.pop(context);
            }
          }),
          child: IconButton(
            onPressed: () async{
                final bool shouldPop = await _showBackDialog() ?? false;
                if (context.mounted  && shouldPop) {
                  Navigator.pop(context);
                }
             
            },
            icon: const Icon(Icons.close),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                   color: Colors.black26, 
                   width: 1,
                ),
              )
            ),

          
          ),
          Expanded(
            // Rich Text Editor
            child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                placeholder: 'Add content here...',
                scrollable: true,
                controller: _controller
                ),
            ),
          )
        ],
      ),
    );
  }
}
