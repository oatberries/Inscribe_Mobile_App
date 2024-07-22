import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inscribevs/components/login/elevated_button.dart';
import 'dart:convert';

class verifyPage extends StatelessWidget {
  final String email;
  const verifyPage({required this.email, super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [

          const SizedBox(height: 25),
          const Text(
            'Verification Email Has Been Sent!',
            style: TextStyle( fontSize: 25)
          ),

          const SizedBox(height: 15),

          const Text(
            'We have just sent an email verification link to your email.\nPlease check your email and click on the link to verify your account',
            style: TextStyle( fontSize: 15)
          ),

          const SizedBox(height: 15),

           const Text(
            'Tap Continue to Return to the Login Screen',
            style: TextStyle( fontSize: 15)
          ),
          
          ElevatedButtonWithoutIcon(
            labelText: 'Continue', 
            onPressed: () => Navigator.pushNamed(context, '/loginpage')
          ),
        ],
      ),

    );
  }
}