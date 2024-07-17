import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inscribevs/pages/login_page.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;

  void log(message) => print(message);
  //final String text;
  //final form;
  /*
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();*/
  /*TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;*/



  //const MyButton({required this.onPressed, required this.form, super.key
 //});
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
        /*  onPressed: (){
            if (form.currentState!.validate()){
              
              Future<void> _login() async{
              //Future<void> _login(TextEditingController firstNameController, TextEditingController lastNameController, TextEditingController emailController, 
              //TextEditingController usernameController, TextEditingController passwordController, TextEditingController confirmPasswordController) async{
                      final String firstName = firstNameController.text;
                      final String lastName = lastNameController.text;
                      final String email = emailController.text;
                      final String username =  usernameController.text;
                      final String password = passwordController.text;
                      final String confirmPassword = confirmPasswordController.text;
                      final bool terms = true;


                      //API endpoint url
                      const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/auth/register';

                      //Call the API endpoint 
                      final response = await http.post(
                        Uri.parse(URL),
                        headers: <String, String> {
                          'Content-Type': 'application/json; charset=UTF-8'
                        },
                        body: json.encode(<String, dynamic>{
                          'first_name' : firstName,
                          'last_name' : lastName,
                          'email': email,
                          'username' : username,
                          'password': password,
                          'confirm_password': confirmPassword,
                          'terms': true
                        })
                      );

                      //if the response is ok
                      if(response.statusCode == 201){

                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        );

                        final responseData = jsonDecode(response.body);
                        print('Registration successful: ${responseData}');

                      }
                      else{
                        print('Registration failed: ${response.body}');
                      }

                  }

          }*/
          //},
        
       /*   onPressed:(){
             Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()),
            );
          },*/
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
