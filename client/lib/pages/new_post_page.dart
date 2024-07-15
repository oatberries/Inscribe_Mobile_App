
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  
  Future <void> _newPost() async{
    

  }
  @override
  Widget build(BuildContext context) { 
  
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
                onPressed: () {},
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

            // Horizontal Scrollable Rich Editor Tool Bar
            child: QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                controller: _controller,
                color: const Color.fromRGBO(216, 243, 220,1),
                multiRowsDisplay: false,
                showAlignmentButtons: true,
                ),
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
