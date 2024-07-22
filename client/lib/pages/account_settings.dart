import 'package:flutter/material.dart';
import 'package:inscribevs/components/login/elevated_button.dart';
import 'package:inscribevs/components/top_bar.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 243, 220),
      appBar: TopBar(title: 'Account Settings'),
      body: Center(
        child: Column(
          children: [

            
          ],
        ),
      )
    );
  }
}