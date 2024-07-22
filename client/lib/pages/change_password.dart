import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/components/login/elevated_button.dart';
import 'package:inscribevs/components/register/my_textfield.dart';
import 'package:inscribevs/components/top_bar.dart';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;


class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

    bool isValid = false;
    bool hasCurrPassErr = false;
    List CurrPassErrList = [];
    String CurrPassErr = '';
    final GlobalKey<FormState> form = GlobalKey<FormState>();
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();


    void onChanged() {
    setState(() {
      isValid = form.currentState!.validate();
      hasCurrPassErr = false;
    });
    
  }

    @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    Future<void> _changePassword() async {

      DataService secureStorage = DataService.getInstance;
      String token = await secureStorage.read('token');

      String currentPassword = currentPasswordController.text.trim();
      String newPassword = newPasswordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      
    const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/update-password';

   final response = await http.patch(
      Uri.parse(URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(<String,String> {
        'current_password' : currentPassword,
        'new_password' : newPassword,
        'confirm_password':  confirmPassword
      }),
    );


    if (response.statusCode == 200)
    {
      final responseData = jsonDecode(response.body);
      print("Update Password is successful ${responseData}");
         var snackbar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success', 
            message: 'Password Updated!', 
            contentType: ContentType.success
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.pop(context);
    } else {
      print("Update Password is unsuccessful ${response.body}");
      final responseData = jsonDecode(response.body);
      String error = responseData['message'];
      

      if (error.isNotEmpty || error.length != 0) {
        hasCurrPassErr = true;
        CurrPassErr = error;
      }
      print("\n Response Data Password Error List: ${error} \n");
      print("\n Current Password Error List: ${CurrPassErr} \n");
    }

    }

    
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 243, 220),
      appBar: TopBar(title: 'Change Password'),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: form,
            onChanged: () {
              onChanged();
            },
        
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height:25),
            
             MyTextField(
                controller: currentPasswordController, 
                errorMsg: 'Current Password Field cannot be empty',
                hintText: 'Current Password', obscureText: true, 
                isEmailField: false, 
                isUsernameField: false, 
                isPasswordField: true, 
                Takenerr: CurrPassErr, isTakenErr: hasCurrPassErr),
        
                const SizedBox(height: 10),
        
              MyTextField(
                controller: newPasswordController, 
                errorMsg: 'New Password Field cannot be empty', 
                hintText: 'New Password', obscureText: true, 
                isEmailField: false, 
                isUsernameField: false, 
                isPasswordField: true, 
                Takenerr: '', 
                isTakenErr: false),

                const SizedBox(height: 10),
            
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
          
                    if (value.toString() != newPasswordController.text)
                    {
                        return "• Passwords do not match";
                    }
                    return null;
                  },
                ),
              ),
        
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: isValid? () {
                    //async method
                    _changePassword();
                  } : null, 
                  child:  Text("Update Password")
                ),
              ),
              ],
            ),
          ),
        ),
      )
    );
  }
}