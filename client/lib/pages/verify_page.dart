import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inscribevs/components/login/elevated_button.dart';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:inscribevs/globals.dart' as globals;

class verifyPage extends StatelessWidget {
  final String email;
  const verifyPage({required this.email, super.key});

  @override
  Widget build(BuildContext context) {

    String URL = '${globals.base_url}/auth/send-verify';

     Future <void> _verifyEmail() async {

      final response = await http.post( 
        Uri.parse(URL),

        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(<String, dynamic>{
          'email': email,
        })

      );

       if(response.statusCode == 200) {

        var responseData = jsonDecode(response.body);
        print("Sent an email verification link!");
        Navigator.pushReplacementNamed(context, '/loginpage');
        print("${responseData}");

         var snackbar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success', 
            message: 'Email Verification Link has been sent!', 
            contentType: ContentType.success
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
       } else {
          print("Did not successfully send email request: ${response.body}");
       }
    };


    return Scaffold(
      body: Column(
        children: [

          const SizedBox(height: 25),
          const Text(
            'Email Verification Required!',
            style: TextStyle( fontSize: 25)
          ),

          const SizedBox(height: 15),

          const Text(
            'Account Creation is successful! Please check your email for a verification link to our app!',
            style: TextStyle( fontSize: 15)
          ),

          const SizedBox(height: 15),

           const Text(
            'Tap Verify Email to send an email verification',
            style: TextStyle( fontSize: 15)
          ),
          
          ElevatedButtonWithoutIcon(
            labelText: 'Verify Email', 
            onPressed: () => _verifyEmail(),
          ),
        ],
      ),

    );
  }
}