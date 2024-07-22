
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final controller;
  final errorMsg;
  final String hintText;
  final bool isEmailField;
  final bool isPasswordField;
  final bool isUsernameField;
  final bool obscureText;
  final bool isTakenErr;
  final String Takenerr;

  

  const MyTextField({
    super.key,
    required this.controller,
    required this.errorMsg,
    required this.hintText,
    required this.obscureText,
    required this.isEmailField,
    required this.isUsernameField,
    required this.isPasswordField,
    required this.Takenerr,
    required this.isTakenErr,

  });
  

 
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: 300,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty || value.toString().trim().length == 0)
          {
            return '• $hintText is required and cannot be a whitespace';
          }

          if (isEmailField){

            String emailStr = value.toString().trim();

            if (emailStr.length > 50)
            {
              return "• Email cannot exceed 50 characters";
            }
             final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                               .hasMatch(emailStr);
            if(!emailValid)
            {
              return "• Invalid email format";
            }

            if(isTakenErr) {
              return '• ${Takenerr}';
            }
          }
          else if (isPasswordField) {
              String passwordStr = value.toString().trim();
              String errMsg = "";

              if (passwordStr.length < 8){
                errMsg += "• Password must contain at least 8 characters.\n";
              }

              if (passwordStr.length > 64)
              {
                errMsg += "• Password must not exceed 64 letters.\n";
              }

              if (!passwordStr.contains(RegExp(r'[A-Z]'))) {
                errMsg += '• Password must contain an uppercase letter.\n';
              }
              // Contains at least one lowercase letter
              if (!passwordStr.contains(RegExp(r'[a-z]'))) {
                errMsg += '• Password must contain a lowercase letter.\n';
              }
              // Contains at least one digit
              if (!passwordStr.contains(RegExp(r'[0-9]'))) {
                errMsg += '• Password must contain a digit.\n';
              }
              // Contains at least one special character
              if (!passwordStr.contains(RegExp(r'[@$!%*?&_-]'))) {
                errMsg += '• Password must contain a special character.\n';
              }


              // If there is no errors
              if (errMsg.isEmpty)
              {
                return null;
              }

              return errMsg;
          }
          else if (isUsernameField)
          {
            String usernameStr = value.toString().trim();
            final bool validField = RegExp(r"^[a-zA-Z][;a-zA-Z0-9-_]{0,49}$").hasMatch(usernameStr);

            if (usernameStr.length > 50){      
              return '• Username must not exceed 50 characters in length';
            }

            if (!validField){
              return '• Username must start with a letter and can only contain letters, numbers, hyphens, and underscores';
            }

            if(isTakenErr) {
              return '• ${Takenerr}';
            }
            
          }
          else {

            String displayNameText = value.toString().trim();
            final bool isValidName = RegExp(r"^[A-Za-z '-]{1,50}$").hasMatch(displayNameText);
            if (displayNameText.length > 50)
            {
              return "• $hintText cannot exceed 50 characters";
            }

            if (!isValidName)
            {
              return "• $hintText can only contain letters, spaces, hypens, and apostrophes";
            }
          }
          return null;
        },
        decoration: InputDecoration(
          errorMaxLines: 5,
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