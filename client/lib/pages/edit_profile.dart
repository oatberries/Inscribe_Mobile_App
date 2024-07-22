import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/components/list_view_profile_buttons.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}



class _EditProfileState extends State<EditProfile> {

  late Future <void> tokenMethod;

 final secureStorage = DataService.getInstance;
  String token = '';
  String firstName = '';
  String lastName = '';
  String bio = '';
  void initState() {
    super.initState();
    //tokenMethod = _getToken();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 243, 220),
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontSize: 14,
          ),
        ),
        centerTitle: true,
        // Go back
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back)),
      ), 
      body: Center(
        child: Center(
                child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1
                        ),
                        // top: BorderSide(
                        //   width: 1
                        // ),
                      )
                    ),
                    child: const SizedBox(height: 25)),
                  
                  ListViewProfileButtons(
                    onPressed: () {
                      Navigator.pushNamed(context, '/changenamepage');
                    }, 
                    labelText: '', 
                    displayText: 'Change First Name and Last Name'
                  ),

                  ListViewProfileButtons(
                    onPressed: () {
                       Navigator.pushNamed(context, '/changebiopage');
                    }, 
                    labelText: '', 
                    displayText: 'Change Bio',
                  ),
              ],
            ),
          ),
        ),
      );
  }
}