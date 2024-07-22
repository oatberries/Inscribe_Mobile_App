import 'package:flutter/material.dart';

class MyLoginTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final bool isUsernameField;
  final bool isPasswordField;

  const MyLoginTextField({
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.isUsernameField,
      required this.isPasswordField
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: obscureText,
        //style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Helvetica', fontWeight: FontWeight.normal),
        validator: (value){
          if (value == null || value.isEmpty){
            return 'Please enter a $hintText';
          }
          return null;
        },
        decoration: InputDecoration(
          isDense: true,
          // errorStyle: TextStyle(height: 0.2, fontSize: 8),
          // errorMaxLines: 2,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color.fromARGB(255, 252, 252, 252)),
          ),
          
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          //hintStyle: TextStyle(color: Colors.)
        ),
      ),
    );
  }
}
