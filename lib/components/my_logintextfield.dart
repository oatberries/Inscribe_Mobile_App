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
      height: 45,
      child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter a $hintText';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                   
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
      ),
    );
  }
}
