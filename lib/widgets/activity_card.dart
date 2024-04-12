import 'package:flutter/material.dart';

import '../globals/pallete.dart';

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String value;
  final String level;

  const ActivityCard({super.key, required this.icon, required this.name, required this.value, required this.level});

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    switch (level) {
      case 'low':
        cardColor = Pallete.lowValueColor;
        break;
      case 'moderate':
        cardColor = Pallete.moderateValueColor;
        break;
      case 'high':
        cardColor = Pallete.highValueColor;
        break;
      default:
        cardColor = Colors.white;
    }

    return Card(
      color: cardColor,
      elevation: 5,
      shadowColor: Pallete.blackBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: Icon(
            icon,
            size: 30.0,
            color: Theme.of(context).primaryColorDark,
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                level,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}