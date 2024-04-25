import 'package:flutter/material.dart';

import '../globals/field_range.dart';
import '../globals/pallete.dart';

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String value;
  final VoidCallback onTap;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.name,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    Map<String, int>? thresholds = thresholdValues[name];
    if (thresholds != null) {
      double value = double.parse(this.value);
      if ((1 <= value) && (value <= thresholds['Good']!)) {
        cardColor = Pallete.goodValueColor;
      } else if ((thresholds['Good']! < value) && (value <= thresholds['Moderate']!)) {
        cardColor = Pallete.moderateValueColor;
      } else if ((thresholds['Moderate']! < value) && (value <= thresholds['Poor']!)) {
        cardColor = Pallete.poorValueColor;
      } else if (value > thresholds['Poor']!) {
        cardColor = Pallete.poorValueColor;
      } else {
        cardColor = Pallete.defaultValueColor;
      }
    } else {
      cardColor = Pallete.defaultValueColor;
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cardColor,
        elevation: 5,
        shadowColor: Pallete.blackBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(
              icon,
              size: 30.0,
              color: Pallete.whiteTextColor,
            ),
            title: Text(
              name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Pallete.whiteTextColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Value: $value',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Pallete.whiteTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
