import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutUsCard extends StatelessWidget {
  final String imagePath;
  final String content;

  AboutUsCard({required this.imagePath, required this.content});

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              width: 320,
              child: Text(
                content,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
