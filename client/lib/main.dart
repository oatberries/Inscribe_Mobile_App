import 'package:flutter/material.dart';
import 'package:inscribevs/pages/home.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/pages/home_page.dart';
import 'package:inscribevs/pages/login_page.dart';
import 'package:inscribevs/pages/new_post_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Create Local Side Storage
  final secureStorage = await DataService.getInstance;
  runApp(MyApp(token: await secureStorage.read("token")));
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
      //routes: Routes.getroutes,
      // Checks whether the JWT token has expired and token does exit
      home: (JwtDecoder.isExpired(token) == false && token != null)?HomePage(token: token):LoginPage(),
      //home: LoginPage(),
      routes: <String,WidgetBuilder> {
      //'/homepage' : (BuildContext context) => const UserHome(),
      '/newpostpage' : (BuildContext context) => const NewPostPage(),
      },
      );
      
    
  }
}
