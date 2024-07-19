import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/components/login/elevated_button.dart';
import 'package:inscribevs/components/top_bar.dart';
import 'package:inscribevs/components/register/my_textfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();

    Future<void> _changeUsername() async{

      final secureStorage = DataService.getInstance;
      String token = await secureStorage.read('token');
      final username = usernameController.text.trim();
      
      const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/update-username';
      
      final response = await http.patch(
      Uri.parse(URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(<String,String> {
        'username' : username,
      }),
    );

    if (response.statusCode == 200) {
      
      final responseData = jsonDecode(response.body); 
      print("Username Updating was successful ${responseData}");
      Navigator.pop(context);
      
    } else {
      print("Username Updating was unsuccessful ${response.body}");
    }
      

    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 243, 220),
      appBar: TopBar(title: 'Update Username'),
      body: Center(
        child: Column(
          children: [
        
            const SizedBox(height: 25),
        
            MyTextField(
            controller: usernameController, 
            errorMsg: 'Field cannot be empty',
            hintText: 'Username', 
            obscureText: false, 
            isEmailField: false, 
            isUsernameField: true, 
            isPasswordField: false),
        
            const SizedBox(height: 10),
        
            ElevatedButtonWithoutIcon(labelText: 'Change Username', onPressed: _changeUsername)
        
          ],
        ),
      )
    );
  }
}