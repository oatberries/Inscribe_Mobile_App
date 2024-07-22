import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/components/login/elevated_button.dart';
import 'package:inscribevs/components/register/my_textfield.dart';
import 'package:inscribevs/components/top_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    Future<void> _changePassword() async {

      final secureStorage = DataService.getInstance;
      String token = await secureStorage.read('token');

      String currentPassword = currentPasswordController.text.trim();
      String newPassword = newPasswordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      
    const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/update-password';

   final response = await http.patch(
      Uri.parse(URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(<String,String> {
        'current_password' : currentPassword,
        'new_password' : newPassword,
        'confirm_password':  confirmPassword
      }),
    );


    if (response.statusCode == 200)
    {
      final responseData = jsonDecode(response.body);
      print("Update Password is successful ${responseData}");
      Navigator.pop(context);
    } else {
      print("Update Password is unsuccessful ${response.body}");
    }

    }
    return Form(
      child: Scaffold(
      
        backgroundColor: Color.fromARGB(255, 216, 243, 220),
        appBar: TopBar(title: 'Update Password'),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 25),
              
              MyTextField(
                controller: currentPasswordController, 
                errorMsg: 'Please enter your current password', 
                hintText: 'Current Password', 
                obscureText: true, 
                isEmailField: false, 
                isUsernameField: false, 
                isPasswordField: true,
                 isTakenErr: false,
                        Takenerr: '',
              ),
          
              const SizedBox(height: 10),
      
               MyTextField(
                controller: newPasswordController, 
                errorMsg: 'Please enter your new password', 
                hintText: 'New Password', 
                obscureText: true, 
                isEmailField: false, 
                isUsernameField: false, 
                isPasswordField: true,
                isTakenErr: false,
                Takenerr: '',
              ),
          
              const SizedBox(height: 10),
          
          
              SizedBox(
                width: 300, 
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                  errorMaxLines: 2,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                  ),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                        return '• Confirm Password is required and cannot be a whitespace';
                    }
          
                    if (value.toString().length < 8)
                    {
                      return "• Confirm Password must contain at least 8 letters";
                    }
          
                    if(value.toString().length > 64)
                    {
                      return "• Confirm Password must not exceed 64 characters";
                    }
          
                    if (value.toString() != newPasswordController.text)
                    {
                        return "• Passwords do not match";
                    }
                    return null;
                  },
                ),
              ),
          
                const SizedBox(height: 10),
          
                ElevatedButtonWithoutIcon(labelText: 'Update Password',
                 onPressed: _changePassword)
            ],
          ),
        ),
      
      ),
    );
  }
}