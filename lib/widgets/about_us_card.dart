import 'package:flutter/material.dart';

class AboutUsCard extends StatelessWidget {
  final String imagePath;
  final String content;

  const AboutUsCard({super.key, required this.imagePath, required this.content});

  @override
  Widget build(BuildContext context) {
    //get the screen width using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                imagePath,
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SizedBox(
                width: screenWidth * 0.8,
                child: Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
