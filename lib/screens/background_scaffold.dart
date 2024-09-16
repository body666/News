import 'package:flutter/material.dart';
class BackgroundScaffold extends StatelessWidget {
  final Widget child;
  final String backgroundImage;

  const BackgroundScaffold({
    Key? key,
    required this.child,
    this.backgroundImage = 'assets/images/backgroundimage.png', // Path to the background image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover, // Ensures the image fills the screen
            ),
          ),
          // Foreground content
          Positioned.fill(
            child: child, // The screen content passed to the Scaffold
          ),
        ],
      ),
    );
  }
}
