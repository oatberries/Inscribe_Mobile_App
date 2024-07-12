import 'package:flutter/material.dart';
import 'package:inscribevs/utils/getAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inscribevs/components/my_loginbutton.dart';
import 'package:inscribevs/components/my_logintextfield.dart';
import 'package:inscribevs/screens/register_page.dart';
import 'package:inscribevs/screens/home_page.dart';

//class LoginScreen extends StatefulWidget{
class LoginPage extends StatefulWidget{
  
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();

}
    //_LoginScreenState createState() => _LoginScreenState();
//}


//class _LoginScreenState extends State<LoginScreen> {
class _LoginPageState extends State<LoginPage> {


final GlobalKey<FormState> form = GlobalKey<FormState>();

  //text editing controllers
  //final usernameController = TextEditingController();
  //final passwordController = TextEditingController();
  //final String hintText;
  //final bool obscureText;
  //Holds the values types in by the user
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async{

      final String username =  usernameController.text;
      final String password = passwordController.text;

      //API endpoint url
      const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/auth/login';

      //Call the API endpoint 
      final response = await http.post(
        Uri.parse(URL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(<String, String>{
          'username' : username,
          'password': password
        })
      );

      //if the response is ok
      if(response.statusCode == 200){

        final responseData = jsonDecode(response.body);
        print('Registration successful: ${responseData}');

      }
      else{
        print('Registration failed: ${response.body}');
      }

  }


  @override
  Widget build(BuildContext context) {
   // final bgcolor = Color(0xD8F3DC);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
       backgroundColor: Color.fromARGB(255, 216, 243, 220),
      // body: MainPage(),
       body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                  const SizedBox(height: 100),
                      
                  //Welcome back! Log in
                  const Text(
                    'Log In',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w400
                    )
                  ),
                    
                const SizedBox(height:20),
      
               // Form(
                  //key: form,
                  //child: Column(
                  ///children: [
      
                //const SizedBox(height: 15),
        
                  //username text field
            MyLoginTextField(
                      controller: usernameController,
                      obscureText: false,
                      hintText: 'username',
                      isUsernameField: true,
                      isPasswordField: false,            
            ),
           
      
                   const SizedBox(height: 10),
                      
                  //password text field
                MyLoginTextField(
                      controller: passwordController,
                      obscureText: false,
                      hintText: 'password',
                      isUsernameField: false,
                      isPasswordField: true,            
            ),
             
                  const SizedBox(height: 10),
                  
                  //Sign in button
                 /*
                        TextButton(
                          onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                        },*/
                        
                       
                          MyLoginButton(onPressed: _login),
                         // style: TextStyle(
                                    
                           // color: Colors.black,
                            // fontSize: 16
                                  
                            // )
                          
                      //),
                    //),
                 // ),
      
                  
             /*     MyLoginButton(
                    //onTap: signUserIn,
                   onTap: postData
                  ),*/
              
                  const SizedBox(height:10),
                  //Forgot Password?
                     //      ElevatedButton(
                /*    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ))
                    },*/
                    //child: 
                    const Text(
                        'Forgot Password?',
                         style: TextStyle(
                         color: Colors.black,
                         fontSize: 16,
                         fontWeight: FontWeight.normal
                      )
                    ),
                 // ),
              
              
                  const SizedBox(height: 2),
                  //Sign Up!
                    TextButton(
                      onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                    },
                      child: const Text(
                      'Sign Up!',
                      style: TextStyle(
                
                        color: Colors.black,
                         fontSize: 16
              
                         )
                      ),
                    ),
                 
                  const SizedBox(height: 50),
                 // ]
                 // )
               // )    /*
                  //or continue with
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                        thickness: 0.5,
                      color: Colors.grey[500],
                      ),
                      ),
                    ],
                    )
                      
                   //)
                  ],
                ),
              ),
           
          ),
        )
      ),
    );
  }
}
/*
class MainPage extends StatefulWidget{
  //String message = "This is a message", newMessageText = '';
  @override
  _MainPageState createState()=> _MainPageState();

}

class _MainPageState extends State<MainPage> {
//String message = "This is a message", newMessageText = '';

String loginName = '', password = '';


  @override
  void initState() {
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return Container(
     // width: 400,
      child:
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontal
              children: <Widget>[
            
                   
             
             Container(
                    child: Center(
                      child: const Text('Log In',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w400
                      )
                      ),
                    ),
                  ),
            
              //username text field
              Row(
                children: <Widget>[
                Container(
                  width: 200,
                  //SizedBox(
                  //child:
                
                  child: Center(
                    child: TextField (
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color.fromARGB(255, 252, 252, 252)),
                            ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                labelText: 'Login Name',
                                hintText: 'Enter Your Login Name'
                          
                            ),
                            onChanged: (text) {
                              loginName = text;
                            },
                          
                          ),
                  ),
                
                  //)
                   // ),
                ),
               ]
              ),
                Row(
                    children: <Widget>[
                      Container(
                       // width: 200,
                        child:
                        TextField (
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color.fromARGB(255, 252, 252, 252)),
                      ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Enter Your Password'
                          ),
                          onChanged: (text) {
                            password = text;
                          },
            
                        ),
                      ),
                    ]
                ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                        child: Text('Do Login',style: TextStyle(fontSize: 14 ,color:Colors.black)),
                        onPressed: ()
                        {
                          Navigator.pushNamed(context, '/home');
                        },
                        //style: ElevatedButton.styleFrom(primary: Colors.brown,),
                        //color:Colors.brown[50],
                        //textColor: Colors.black,
                      // padding: EdgeInsets.all(2.0),
                      // splashColor: Colors.grey[100]
                    ),
                  ),
                  ],
                ),
            
                //String message = "This is a message", newMessageText = '';
            
                     /*       Row(
                    children: <Widget>[
                    Text('$message',style: TextStyle(fontSize: 14 ,color:Colors.black)),
                  ],
                  )*/
            
            
                  
            
              ]
            ),
          )
    );
  }

          /*      changeText(){
                setState((){
                  message = newMessageText;
                });
              }*/
}*/