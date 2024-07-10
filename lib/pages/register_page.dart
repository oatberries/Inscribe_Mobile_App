import 'package:flutter/material.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp()
  {

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
                key: form,
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
                    ),
            
                    const SizedBox(height: 12),
                    
                    // Username
                    MyTextField(
                      controller: usernameController,
                      errorMsg: 'Please enter a username',
                      hintText: 'Username',
                      isUsernameField: true,
                      isEmailField: false,
                      isPasswordField: false,
                      obscureText: false,
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
                    ),
              
                
                    const SizedBox(height: 12),
            
                    // Confirm Password
                    SizedBox(
                     width: 300, 
                     child: TextFormField(
                      controller: confirmPasswordController,
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

                    // Create Account
                    MyButton(text: 'Create Account', form: form),
            
                    const SizedBox(height: 24),

                    // Login Here
                     const InkWell(
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Text('Already registered?'),
                          SizedBox(width: 4),
                          TextButton(onPressed: null, 
                            child: Text(
                              'Login in here',
                              style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                     )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
