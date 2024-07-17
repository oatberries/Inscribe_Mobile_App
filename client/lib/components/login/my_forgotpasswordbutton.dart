import 'package:flutter/material.dart';
import 'package:inscribevs/pages/forgotpassword_page.dart';

class ForgotPasswordbutton extends StatelessWidget {
  const ForgotPasswordbutton({super.key});

  //just for tests!! erase later!
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
       mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
           onTap: (){
             Navigator.push(context, 
              MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
           },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.normal,
                   fontSize: 14,
             ),
                        ),
          ),
        ],
      ),
    );
                
  }
}
