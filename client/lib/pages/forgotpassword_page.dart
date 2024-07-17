import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inscribevs/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>{
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
  }

  Future<String> passwordReset(String email) async {
    //final String email = emailController.text;

    //API endpoint url
    const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/auth/request-password-reset';

    //Call the API endpoint
    final response = await http.post(
        Uri.parse(URL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(<String, String>{
          'email' : email
        })
      );

      if(response.statusCode == 200){
      
        final responseData = jsonDecode(response.body);
        print('${responseData}');
      }
      else{
        //print('Registration failed: ${response.body}');
        throw Exception(response.body);
      }
    return response.body;
  }

  void _showErrorAlertDialog(BuildContext context){
      final alert = AlertDialog(
        content: Text("There was an error with resetting your password. Try again."),
        actions: [ElevatedButton(child: Center(child: Text("OK")), onPressed: (){
          Navigator.push(context, 
                     MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
        })],
      );

      showDialog(context: context,
       builder: (BuildContext context) {
        return alert;
       },
     );
   }

   void _showSuccessAlertDialog(BuildContext context){
      final alert = AlertDialog(
        content: Text("A reset link was sent to your email."),
        actions: [ElevatedButton(child: Text("OK"), onPressed: (){
          Navigator.push(context, 
                     MaterialPageRoute(builder: (context) => LoginPage()));
        })],
      );

      showDialog(context: context,
       builder: (BuildContext context) {
        return alert;
       },
     );
   }

  void _resetButtonClickHandler(){

      final String email = emailController.text;

      passwordReset(email).then((response) {
          _showSuccessAlertDialog(context);

      }).catchError((e){
          _showErrorAlertDialog(context);
      });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 216, 243, 220),
        elevation: 0,
        centerTitle: true,
        title: const Text('Forgot Password',
        style: TextStyle(fontWeight: FontWeight.w500,
        fontSize: 22,
        ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 216, 243, 220),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your email and we will send you a password reset link',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15)
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                //padding: const EdgeInsets.only(top: 50.0),
                child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color.fromRGBO(252, 253, 253, 1)),
                            ),
                            
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Email',
                
                    ),
                  ),
              ),
              SizedBox(height: 10),

                ElevatedButton(
                  onPressed: _resetButtonClickHandler,
                  child: Text('Reset Password'),
                  //style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(82, 183, 136, 1),
                  //)
                )
            ],
          ),
        ),
        
      )
    );
  }
}