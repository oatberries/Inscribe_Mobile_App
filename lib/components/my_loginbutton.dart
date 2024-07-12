import 'package:flutter/material.dart';
import 'package:inscribevs/screens/home_page.dart';
class MyLoginButton extends StatelessWidget {

  //final Function()? onTap;
  final VoidCallback onPressed;

 

  const MyLoginButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 50),
       decoration: BoxDecoration(color: Color.fromRGBO(82,183,136,1),
           borderRadius: BorderRadius.circular(8),
       ),
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: const Center(       
            child: Text(
            "Sign In",
            style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            ),
            ),
          ),
        )
    );
                
  }
}
