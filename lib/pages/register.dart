import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Let\'s make an account!',
                  style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 25),
              ],
            ),
          ),
      ),)
    );
  }
}