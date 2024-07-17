import 'package:flutter/material.dart';
import 'package:inscribevs/pages/register_page.dart';

class Signupbutton extends StatelessWidget {
  const Signupbutton({super.key});

  //just for tests!! erase later!
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      //height: 38,
      //width: 100,
      //child: TextButton(
       // style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 8.0)),
       // style: OutlinedButton.styleFrom(),
      /*     onPressed: () {
      
             //print('Create A New Account');
             Navigator.push(context, 
                     MaterialPageRoute(builder: (context) => RegisterPage()));
           },*/
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                       'Not a member?',
                       style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                      ),
                      //const SizedBox(width: 4)
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Register here',
                        style: TextStyle(
                          color: Colors.blue,
                        )
                      ),
                   ],
                 ),
                ),
               ],
             ),
           )
           
       //),
    );
                
  }
}
