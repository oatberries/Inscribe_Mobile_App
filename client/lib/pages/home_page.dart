import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 243, 220),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 15),
                    // Title
                    Text(
                      'Inscribe',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ],),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Color.fromRGBO(82, 183, 136, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
          child: GNav(
            backgroundColor:const Color.fromRGBO(82, 183, 136, 1),
            color:const  Color.fromRGBO(8, 28, 21, 1),
            activeColor: Color.fromRGBO(216, 243, 220, 1),
            tabBackgroundColor: const  Color.fromRGBO(8, 28, 21, 1),
            gap: 8,
            padding: const EdgeInsets.all(6),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
                ),
              GButton(
                icon: Icons.compass_calibration,
                text: 'Discover'
                ),
              GButton(
                icon: Icons.add_circle,
                text: 'New Post',
                ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            ),
        ),
      ),
      
    );
  }
}