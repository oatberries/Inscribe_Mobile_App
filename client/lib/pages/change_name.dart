import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/components/register/my_textfield.dart';
import 'package:inscribevs/components/login/elevated_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});
  

 

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();

    Future<void> _changeName() async{
      final secureStorage = DataService.getInstance;
      String token = await secureStorage.read('token');
      final String firstName = firstNameController.text;
      final String lastName = lastNameController.text;

      const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/update-name';


    final response = await http.patch(
      Uri.parse(URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(<String,String> {
        'first_name' : firstName,
        'last_name' : lastName,
      }),
    );
         
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
          
        print("Name changing was successful {$responseData}");

      } else {
        print("Name changing was not successful ${response.body}");
      }
    

  }

    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 243, 220),
       appBar: AppBar(
        
        title: const Text(
          'Change Name',
          style: TextStyle(
              fontSize: 14,
          ),
        ),
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back)),
      ), 

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            MyTextField(
            controller: firstNameController, 
            errorMsg: 'Field cannot be empty', 
            hintText: 'First Name', 
            obscureText: false, 
            isEmailField: false, 
            isUsernameField: false, 
            isPasswordField: false,
            isTakenErr: false,
            Takenerr: '',),
            const SizedBox(height: 10),
        
            MyTextField(
            controller: lastNameController, 
            errorMsg: 'Field cannot be empty', 
            hintText: 'Last Name', 
            obscureText: false, 
            isEmailField: false, 
            isUsernameField: false, 
            isPasswordField: false,
            isTakenErr: false,
            Takenerr: ''
            ),
        
          const SizedBox(height: 20),
        
            ElevatedButtonWithoutIcon(
              labelText: 'Confirm Changes', 
              onPressed: _changeName)
        
        
          ],
        ),
      ),
    );
  }
}