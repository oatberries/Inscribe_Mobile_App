import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inscribevs/components/login/elevated_button.dart';
import 'package:inscribevs/components/top_bar.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 243, 220),
      appBar: TopBar(title: 'Account Settings'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 25),
            ElevatedButtonWithoutIcon(
              labelText: 'Change Username', 
              onPressed: () => Navigator.pushNamed(context,'/changeusernamepage'),
            ),
            
            const SizedBox(height: 10),
        
             ElevatedButtonWithoutIcon(
              labelText: 'Change Password', 
              onPressed: () => Navigator.pushNamed(context,'/changepasswordpage'),
            )
          ],
        ),
      )
    );
  }
}