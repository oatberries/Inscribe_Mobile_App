import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
      child: Text(
        'Home'
        ),
    )
    );
  }
}