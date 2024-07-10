import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inscribevs/components/my_loginbutton.dart';
import 'package:inscribevs/components/my_logintextfield.dart';
import 'package:inscribevs/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in
  void signUserIn(){



  }

  @override
  Widget build(BuildContext context) {
    final bgcolor = Color(0xD8F3DC);
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 216, 243, 220),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        
               // const SizedBox(height: 25),
        
              //logo 
         /*     const Icon(
                Icons.login,
                   size: 100
              ),
        */
              const SizedBox(height: 100),
        
              //Welcome back! Log in
              const Text(
                'Log In',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w400
                )
              ),
        
              const SizedBox(height: 15),
        
              //username text field
              MyLoginTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false
              ),
        
               const SizedBox(height: 10),
        
              //password text field
              MyLoginTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true
              ),
/*
              const SizedBox(height: 5),
              //forgot password?
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                         fontSize: 12
                         )
                      ),
                    ],
                  ),
                ),
        */
              const SizedBox(height: 10),
              //Sign in button
              //const SizedBox(height:10),
              MyLoginButton(
                onTap: signUserIn,
              ),

              const SizedBox(height:10),
              //Forgot Password?
       //      ElevatedButton(
            /*    onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ))
                },*/
                //child: 
                const Text(
                    'Forgot Password?',
                    style: TextStyle(
                     color: Colors.black,
                     fontSize: 16,
                     fontWeight: FontWeight.normal
                  )
                ),
             // ),


              const SizedBox(height: 2),
              //Sign Up!
                TextButton(
                  onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
                },
                  child: const Text(
                  'Sign Up!',
                  style: TextStyle(
  
                    color: Colors.black,
                     fontSize: 16

                     )
                                ),
                ),
             
              const SizedBox(height: 50),
        /*
              //or continue with
              Row(
                children: [
                  Expanded(
                    child: Divider(
                    thickness: 0.5,
                  color: Colors.grey[500],
                  ),
                  ),
                ],
                )
        */
            
              ],
            ),
          ),
        ),
      )
    );
  }
}
