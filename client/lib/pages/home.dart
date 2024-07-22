import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}



class _UserHomeState extends State<UserHome> {

  var Info; 
  void initState() {

    setState(() {
      
    });
    //  _getDecodedToken();
    super.initState();
   
    // _getPostsFirst();
    // _controller = ScrollController()..addListener(_loadMorePosts);
    
   }
  
  // Future <void> _getDecodedToken() async{
  //   // final secureStorage = DataService.getInstance;
  //   // String token = await secureStorage.read('token');
  //   // Info = JwtDecoder.decode(token);
  //   // String userId = Info['userId'];
  //   // print("Info is ${Info}");
  //   // print("UserId is ${userId}");
  // }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

     floatingActionButton: FloatingActionButton.small(
          backgroundColor: const Color.fromRGBO(82, 183, 136, 1),
          onPressed: (){
             Navigator.pushNamed(context, '/newpostpage').then((_) => setState(() {}));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),   
      
      body: Center(
      child: Text(''),
    )
    );
  }
}