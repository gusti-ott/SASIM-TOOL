import 'package:flutter/material.dart';

class TitleImage extends StatelessWidget {
  const TitleImage({super.key, required this.imagePath, required this.titleText, this.height});

  final String imagePath;
  final String titleText;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (height != null) ? height : 400, // Fixed height
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, // Fill the width
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust opacity for darkness
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Text(titleText,
                  style:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white, fontSize: 64)),
            ),
          ),
          // Other widgets can be added on top of the image in the Stack
        ],
      ),
    );
  }
}

Widget subheader(BuildContext context, String text) {
  final ThemeData themeData = Theme.of(context);
  final TextTheme textTheme = themeData.textTheme;

  return Stack(
    children: [
      Row(
        children: [
          headerDivider(context),
          Text(
            text,
            style: textTheme.headlineMedium?.copyWith(color: themeData.colorScheme.primary),
          ),
          headerDivider(context),
        ],
      ),
    ],
  );
}

Widget headerDivider(BuildContext context) {
  final ThemeData themeData = Theme.of(context);

  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: themeData.colorScheme.primary,
        thickness: 4,
      ),
    ),
  );
}
