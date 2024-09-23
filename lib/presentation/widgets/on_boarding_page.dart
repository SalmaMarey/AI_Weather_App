import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnBoardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(200, 253, 71, 85),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(height: 20),
          Text(description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromARGB(200, 253, 71, 85), fontSize: 16)),
        ],
      ),
    );
  }
}
