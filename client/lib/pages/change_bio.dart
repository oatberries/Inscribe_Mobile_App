import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'package:inscribevs/components/login/elevated_button.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangeBio extends StatelessWidget {
  const ChangeBio({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController bioController = TextEditingController();
    Future<void> _changeBio () async {

    final secureStorage  = DataService.getInstance;
    String token = await secureStorage.read('token');
    String bio = bioController.text;

    const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/update-bio';

    final response = await http.patch(
      Uri.parse(URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(<String,String> {
        'bio' : bio,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print("Update Bio is successful ${responseData}");
      Navigator.pop(context);
    } else {

      print("Update Bio is unsuccessful ${response.body}");
    }
    }
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 216, 243, 220),
       appBar: AppBar(
        
        title: const Text(
          'Change Bio',
          style: TextStyle(
              fontSize: 14,
          ),
        ),
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back)),
      ), 
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25),
          
              SizedBox(
                width: 350,
                child: TextField(
                  controller: bioController,
                  maxLines: 15,
                
                  decoration: InputDecoration(
                    
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                    hintText: 'Add to Bios here (Max 255 characters)',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButtonWithoutIcon(labelText: 'Change Bio', onPressed: 
              _changeBio)
            ],
          ),
        ),
      ),
    );
  }
}