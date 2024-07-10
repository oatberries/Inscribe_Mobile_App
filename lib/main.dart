import 'package:flutter/material.dart';
import 'package:inscribevs/pages/login_page.dart';
import 'package:inscribevs/pages/register_page.dart';

void main() {
  //runApp(const MainApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //this widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage()
      //home: RegisterPage()
     
      );
      
    
  }
}
