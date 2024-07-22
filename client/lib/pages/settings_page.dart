import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Future<void> _deleteAccount() async {
    final secureStorage = DataService.getInstance;
    String token = await secureStorage.read('token');

    const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/delete-account';

    final response = await http.post(
      Uri.parse(URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },  
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      Navigator.pushReplacementNamed(context, '/loginpage');
      print("Account Deletion is successful: ${responseData}");

    } else {

    }
    

  }


  void _showDeleteConfirmation() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Delete Account Confirmation'),
        content: Text('Are you sure you want to delete your account? This action is irreversible.'),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red),),
          ),
          MaterialButton(
            onPressed: () {
             _deleteAccount();
            },
            child: Text('Delete',style: TextStyle(color: Colors.blue)),
          )
        ],
      );

    });
  }
  @override
  Widget build(BuildContext context) {
    final secureStorage = DataService.getInstance;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 243, 220),
        body: SafeArea(
          child: Center(
            child: Column (
              children: [
          
                const SizedBox(height: 15),

                const Text(
                  'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/editprofilepage');
                    }, 
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Profile Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                      ),
                    
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8)
                      
                      ),
                      backgroundColor:const Color.fromRGBO(82,183,136,1)
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/accountsettingspage');
                    }, 
                    icon: Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                    
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8)
                      
                      ),
                      backgroundColor:const Color.fromRGBO(82,183,136,1)
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showDeleteConfirmation();
                    }, 
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Delete Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                    
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8)
                      
                      ),
                      backgroundColor:const Color.fromRGBO(82,183,136,1)
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton.icon(

                    onPressed: () async{
                      secureStorage.delete('token');
                      print(await secureStorage.read('token'));
                      Navigator.pushReplacementNamed(context, '/loginpage');
                    }, 
                    icon: Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Log off',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                    
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8)
                      ),
                      backgroundColor:const Color.fromRGBO(82,183,136,1)
                    ),
                  ),
                ),
              ],
            )
          ),
          
        )
    );
  }
}