import 'package:flutter/material.dart';

import '../globals/pallete.dart';

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String value;

  const ActivityCard({super.key, required this.icon, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Add elevation
      shadowColor: Pallete.blackBackgroundColor, // Add shadow color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Add border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Add padding
        child: ListTile(
          leading: Icon(
            icon,
            size: 30.0, // Increase icon size
            color: Theme.of(context).primaryColorLight, // Change icon color
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 20.0, // Increase text size
              fontWeight: FontWeight.bold, // Make text bold
            ),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(
              fontSize: 16.0, // Increase text size
            ),
          ),
        ),
      ),
    );
  }
}
