import 'package:flutter/material.dart';
import 'package:inscribevs/pages/register_page.dart';

class ForgotPasswordbutton extends StatelessWidget {
  const ForgotPasswordbutton({super.key});

  //just for tests!! erase later!
  @override
  Widget build(BuildContext context) {

    return Container(
      child: TextButton(
           onPressed: () {

            //change navigation from RegisterPage to ForgotPasswordPage
             Navigator.push(context, 
                     MaterialPageRoute(builder: (context) => RegisterPage()));
           },
           //style: TextButton.styleFrom(),
           child: const Center(
             child: Text(
               'Forgot Password?',
               style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
              ),
            ),
          )
           
       ),
    );
                
  }
}
