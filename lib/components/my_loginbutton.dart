import 'package:flutter/material.dart';
import 'package:inscribevs/pages/login_page.dart';

class MyLoginButton extends StatelessWidget {

  final Function()? onTap;

  const MyLoginButton({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 50),
         decoration: BoxDecoration(color: Color.fromRGBO(82,183,136,1),
             borderRadius: BorderRadius.circular(8),
         ),
          child: const Center(
            child: Text(
            "Sign In",
            style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            ),
            ),
          ),
        ),
    );
                
  }
}