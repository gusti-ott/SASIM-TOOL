import 'package:flutter/material.dart';

class TitleImage extends StatelessWidget {
  const TitleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.0, // Fixed height
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/title_image/titelbild_ubahn.png',
              fit: BoxFit.cover, // Fill the width
            ),
          ),
          Positioned.fill(
            child: Container(
              color:
                  Colors.black.withOpacity(0.5), // Adjust opacity for darkness
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Text('Das sind die wahren Kosten deiner Mobilität?',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.white, fontSize: 64)),
            ),
          ),
          // Other widgets can be added on top of the image in the Stack
        ],
      ),
    );
  }
}
