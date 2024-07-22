import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;

  void log(message) => print(message);
  
const MyButton({required this.onPressed, super.key});
//validate the fields first, THEN make the api call
/*MyButton({required this.form, required this.onPressed, required this.firstNameController, required this.lastNameController,
required this.emailController, required this.usernameController, required this.passwordController, required this.confirmPasswordController, super.key});*/
  @override
  Widget build(BuildContext context) {
    return InkWell(
     /*  onTap: ()
        {
          if (form.currentState!.validate()){
            log('Success');
          }
        },*/
      child: Container(
        width: 300,
        height: 40,
        //padding:const EdgeInsets.all(10),
        margin:const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(82,183,136,1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(82, 183, 136, 1)),
          onPressed: onPressed,
          child: const Center(
            child: Text(
              "Create Account",
              style: TextStyle(
              color:Colors.white,
              fontSize: 14
              ),
            ),
          ),
        ),
      ),
    );
  }
}
