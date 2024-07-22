import 'package:flutter/material.dart';
import 'package:inscribevs/pages/change_password.dart';
import 'package:inscribevs/pages/change_username.dart';
import 'package:inscribevs/pages/edit_profile.dart';
import 'package:inscribevs/pages/change_name.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/pages/home_page.dart';
import 'package:inscribevs/pages/login_page.dart';
import 'package:inscribevs/pages/verify_page.dart';
import 'package:inscribevs/pages/new_post_page.dart';
import 'package:inscribevs/pages/change_bio.dart';
import 'package:inscribevs/pages/account_settings.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Create Local Side Storage
  final secureStorage = await DataService.getInstance;
  String token = '';

    // if the token does exist in the storage
  if (await secureStorage.read('token') != null) {
   token = await secureStorage.read('token');

   if(JwtDecoder.isExpired(token) == true)
  {
    secureStorage.delete('token');
  }

  }
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //      String storedToken = await secureStorage.read('token');
  //      print(storedToken);
  //  });
  runApp(MyApp(token: await secureStorage.read('token')));
}

@override
class MyApp extends StatelessWidget {
  final token;
    MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

  //this widget is the root of your application
 
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),

      // Checks whether the JWT token has expired and token does exit
      home: (token != null && JwtDecoder.isExpired(token) == false)?HomePage(token: token):LoginPage(),
      
      routes: <String,WidgetBuilder> {
      '/verifyPage' : (BuildContext context) => verifyPage(email: AutofillHints.email),
      '/loginpage' : (BuildContext context) => LoginPage(),
      '/newpostpage' : (BuildContext context) => const NewPostPage(),
      '/editprofilepage' : (BuildContext context) => const EditProfile(),
      '/changenamepage' : (BuildContext context) => const ChangeName(),
      '/changebiopage' : (BuildContext context) => const ChangeBio(),
      '/accountsettingspage' : (BuildContext context) => const AccountSettings(),
      '/changeusernamepage' : (BuildContext context) => const ChangeUsername(),
      '/changepasswordpage' : (BuildContext context) => const ChangePassword()

      
      },
    );
  }
}
