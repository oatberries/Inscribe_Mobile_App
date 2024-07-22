import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inscribevs/components/register/my_registerbutton.dart';
import 'package:inscribevs/components/register/my_textfield.dart';
//import 'package:inscribevs/screens/LoginScreen.dart';
import 'package:inscribevs/pages/login_page.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:inscribevs/pages/profile_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  //State<RegisterPage> createState() => _RegisterPageState();
  _RegisterPageState createState(){
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  List emailErrorList = [];
  List userNameErrorList = [];
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  

  bool isValid = false;
  bool hasUserErr = false;
  bool hasEmailErr = false;
  String UserErr = '';
  String EmailErr = '';



  void onChanged() {
    setState(() {
      isValid = form.currentState!.validate();
      hasUserErr = false;
      hasEmailErr = false;
    });
    
  }

    @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
  // //get onPressed => null;
/*
      final String firstName = firstNameController.text;
      final String lastName = lastNameController.text;
      final String email = emailController.text;
      final String username =  usernameController.text;
      final String password = passwordController.text;
      final String confirmPassword = confirmPasswordController.text;*/

   Future<void> _register() async{

      final String firstName = firstNameController.text;
      final String lastName = lastNameController.text;
      final String email = emailController.text;
      final String username =  usernameController.text;
      final String password = passwordController.text;
      final String confirmPassword = confirmPasswordController.text;

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
      if (response.statusCode == 201){

        //Navigator.push(context, MaterialPageRoute(builder: (context) => verifyPage(email: emailController.text)));
        Navigator.pushReplacementNamed(context, '/loginpage');

        final responseData = jsonDecode(response.body);
        print('Registration successful: ${responseData}');

        
        var snackbar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success', 
            message: 'Account created successfully. Email Verification sent', 
            contentType: ContentType.success
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);

      }
      else{
        
        final responseData = jsonDecode(response.body);

        List errorList = responseData['errors'] as List;
        emailErrorList = errorList.where((element) => element['field'] == 'email').toList();
        userNameErrorList = errorList.where((element) => element['field'] == 'username').toList();
        
        

        print('Registration failed: ${responseData}');
         setState(() {
          if (userNameErrorList.isNotEmpty) {
             hasUserErr = true;
             UserErr = userNameErrorList[0]['message'];
          }

          if (emailErrorList.isNotEmpty) {
            hasEmailErr = true;
            EmailErr = emailErrorList[0]['message'];
          }
         
         // List curError = errorList.firstWhere((element) => element[''] == 'a').toList();
          print("\n Username Error List: ${userNameErrorList} \n");
          print("\n Email Error List: ${emailErrorList} \n");
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 243, 220),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
               const SizedBox(height: 12),
                
                // Let's create your account
                const Text(
                  'Let\'s create your account!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
              const SizedBox(height: 20),
            
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: form,
                 onChanged: () {
                    onChanged();
                  },
                child: Column(
                  children: [
          
    
                   
                   // First Name
                    MyTextField(
                      controller: firstNameController,
                      errorMsg: 'Please enter your first name',
                      hintText: 'First Name',
                      isEmailField: false,
                      isPasswordField: false,
                      isUsernameField: false,
                      obscureText: false,
                      isTakenErr: false,
                      Takenerr: '',
                    ),
            
                    const SizedBox(height: 12),
            
                    // Last Name Field
                    MyTextField(
                      controller: lastNameController,
                      errorMsg: 'Please enter your last name',
                      hintText: 'Last Name',
                      isEmailField: false,
                      isPasswordField: false,
                      isUsernameField: false,
                      obscureText: false,
                      isTakenErr: false,
                      Takenerr: '',
                    ),
            
                    const SizedBox(height: 12),
    
                  // Email Field
                    MyTextField(
                      controller: emailController,
                      errorMsg: 'Please enter your last name',
                      hintText: 'Email',
                      isEmailField: true,
                      isUsernameField: false,
                      isPasswordField: false,
                      obscureText: false,
                      isTakenErr: hasEmailErr,
                      Takenerr: EmailErr,
                    ),
            
                    const SizedBox(height: 12),
    
                    // Username
                    MyTextField(
                      controller: usernameController,
                      errorMsg: 'Please enter your last name',
                      hintText: 'Username',
                      isEmailField: false,
                      isUsernameField: true,
                      isPasswordField: false,
                      obscureText: false,
                      isTakenErr: hasUserErr,
                      Takenerr: UserErr,
    
                    ),
              
    
                  
              
                    const SizedBox(height: 12),
            
                    // Password
                    MyTextField(
                      controller: passwordController,
                      errorMsg: 'Please enter a password',
                      hintText: 'Password',
                      isUsernameField: false,
                      isEmailField: false,
                      isPasswordField: true,
                      obscureText: true,
                      isTakenErr: false,
                      Takenerr: '',
                    ),
              
                
                    const SizedBox(height: 12),
            
                    // Confirm Password
                    SizedBox(
                     width: 300, 
                     child: TextFormField(
                      controller: confirmPasswordController,
                      autovalidateMode:AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                      errorMaxLines: 2,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                      validator: (value) {
                        if (value == null || value.isEmpty){
                            return '• Confirm Password is required and cannot be a whitespace';
                        }
    
                        if (value.toString().length < 8)
                        {
                          return "• Confirm Password must contain at least 8 letters";
                        }
    
                        if(value.toString().length > 64)
                        {
                          return "• Confirm Password must not exceed 64 characters";
                        }
    
                        if (value.toString() != passwordController.text)
                        {
                            return "• Passwords do not match";
                        }
                       return null;
                      },
                     ),
                   ),
                  
                    const SizedBox(height: 12),
    
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: isValid? () {
                          _register();
                        } : null, 
                        child:  Text("Create Account")
                      ),
                    ),
    
            
                    const SizedBox(height: 24),
    
                    // Login Here
                     //const InkWell(
                       //child: Row(
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const Text('Already registered?'),
    
    
    
                         const SizedBox(width: 4),
                          TextButton(
                              onPressed: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                            },
                            child: const Text(
                              'Login in here',
                              style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                     //)
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
   // );
  }
}
