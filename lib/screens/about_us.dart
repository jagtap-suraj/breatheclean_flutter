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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 80),
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
    );
  }
}
