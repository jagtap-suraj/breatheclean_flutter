import 'package:breatheclean_flutter/screens/about_us.dart';
import 'package:breatheclean_flutter/globals/pallete.dart';
import 'package:breatheclean_flutter/screens/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bottom_navigation_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  String appbarText = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appbarText,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'BreatheClean',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Your Daily Air Quality Companion',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 5, // Adjust as needed
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Set the Row size to the minimum
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(2.0), // Add padding if needed
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.info_rounded,
                      size: 20.0, // Adjust as needed
                    ),
                  ),
                  const SizedBox(width: 10.0), // Add space between the icon and text
                  const Text('About Us'),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Pallete.blackBackgroundColor,
                elevation: 5.0, // Adjust as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust as needed
                ),
                child: Image.asset(
                  'assets/images/test2.png',
                  width: 400,
                  height: 400,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder: (context, bottomNavProvider, child) {
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
            currentIndex: bottomNavProvider.currentIndex,
            selectedItemColor: Pallete.navigationButtonOn,
            onTap: (index) {
              bottomNavProvider.changeIndex(index);
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ActivityScreen()),
                );
              }
            },
          );
        },
      ),
    );
  }
}
