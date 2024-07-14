import 'package:flutter/material.dart';
import 'package:inscribevs/pages/register_page.dart';

class Signupbutton extends StatelessWidget {
  const Signupbutton({super.key});

  //just for tests!! erase later!
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 40,
      child: TextButton(
           onPressed: () {
      
             //print('Create A New Account');
             Navigator.push(context, 
                     MaterialPageRoute(builder: (context) => RegisterPage()));
           },
           style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
           ),
           child: const Center(
             child: Text(
               'Sign Up!',
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
