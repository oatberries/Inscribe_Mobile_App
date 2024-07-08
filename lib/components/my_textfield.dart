import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final controller;
  final errorMsg;
  final String hintText;
  final bool isEmailField;
  final bool isPasswordField;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.errorMsg,
    required this.hintText,
    required this.obscureText,
    required this.isEmailField,
    required this.isPasswordField

  });
  

 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty)
          {
            return errorMsg;
          }

          if (isEmailField){
             final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value);
                        if(!emailValid)
                        {
                          return "Please enter a valid email";
                        }
          }
          else if (isPasswordField) {
              String passwordStr = value.toString();
              if (passwordStr.length < 8){
                return 'Password must contain 8 letters';
              }
          }
          else {
            final bool validField = RegExp(r'^[a-zA-Z0-9&%=]+$').hasMatch(value);
            if (!validField){
              return 'Field must only contain numbers and letters';
            }
          }
          return null;
        },
        decoration: InputDecoration(
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
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    ); 
  }
}