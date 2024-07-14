import 'package:flutter/material.dart';

class MyLoginButton extends StatelessWidget {

  //final Function()? onTap;
  final VoidCallback onPressed;

  const MyLoginButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 45,

      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Color.fromRGBO(82,183,136,1),
        borderRadius: BorderRadius.circular(8),
       ),
        child: TextButton(
           style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(82,183,136,1)),
           onPressed: onPressed,
  
           child: const Center(   
            
                child: Text(
                  "Sign In",
                    style: TextStyle( 
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                ),
            
            ),

          ),

        )
    );
                
  }
}
