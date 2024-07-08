import 'package:flutter/material.dart';

void main() {
  //runApp(const MainApp());
  runApp(const MyWidget());
}
/*
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        //primarySwatch: Colors.blue;
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
*/
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 187, 230, 189),
        appBar: AppBar(
          
        //backgroundColor: Color.fromARGB(255, 187, 230, 189),
        title: const Text('Inscribe'),
        
          
          //decoration: BoxDecoration(backgroundBlendMode: context
          ),
        ),
      );
      
    
  }
}
