import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inscribevs/pages/home.dart';
import 'package:inscribevs/pages/new_post_page.dart';
import 'package:inscribevs/pages/discover_page.dart';
import 'package:inscribevs/pages/profile_page.dart';
import 'package:inscribevs/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  final token;
  const HomePage({required this.token,super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  // List of pages
  final List<Widget> _pages = <Widget>[
    UserHome(),
    DiscoverPage(),
    ProfilePage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 243, 220),
      body: _pages[_currentPageIndex],
      // Bottom Navigation Bar  
      bottomNavigationBar: Container(
        color: Color.fromRGBO(82, 183, 136, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
          child: GNav(
            onTabChange: (index) {
            // Navigates to the page based on index
            
              setState(() {
                _currentPageIndex = index;

              });  
          
            },
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