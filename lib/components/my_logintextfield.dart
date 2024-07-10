import 'package:flutter/material.dart';

class MyLoginTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyLoginTextField({
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
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
    );
  }
}

