import 'package:flutter/material.dart';
import 'package:breatheclean_flutter/globals/labels.dart';
import 'package:breatheclean_flutter/widgets/about_us_card.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Column(
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 80),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                AboutUsCard(
                  imagePath: 'assets/images/sakec.jpg',
                  content: sakecDiscription,
                ),
                AboutUsCard(
                  imagePath: 'assets/images/rc.png',
                  content: rcDiscription,
                ),
                AboutUsCard(
                  imagePath: 'assets/images/icon.png',
                  content: teamDiscription,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
