import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final controller;
  final errorList;
  final bool hasError;
  final String message;
  //final bool isConfirmPassword;
  const FormTextField({required this.controller, required this.errorList, required this.hasError, required this.message,super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: controller,
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
                              hintText: 'Username',
                              hintStyle: TextStyle(color: Colors.grey[500]), ),
                              validator: (_) => errorList ? errorList[0][message] : null)
                             
                          );
  }
}