import 'package:flutter/material.dart';

import '../globals/pallete.dart';
import '../screens/activity_screen.dart';
import '../screens/home_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.air),
          label: 'Activities',
        ),
      ],
      currentIndex: _currentIndex,
      selectedItemColor: Pallete.navigationButtonOn,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ActivityScreen()),
          );
        } else if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        }
      },
    );
  }
}
