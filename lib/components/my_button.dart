import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  void log(message) => print(message);
  final String text;
  final form;
  const MyButton({super.key, required this.text, required this.form
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ()
        {
          if (form.currentState!.validate()){
            log('Success');
          }
        },
      child: Container(
        width: 300,
        height: 40,
        padding:const EdgeInsets.all(10),
        margin:const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(82,183,136,1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Create Account",
            style: TextStyle(color:Colors.white)
          ),
        ),
      ),
    );
  }
}