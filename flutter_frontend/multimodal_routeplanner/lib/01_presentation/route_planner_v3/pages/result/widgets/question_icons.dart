import 'package:flutter/material.dart';

Widget customQuestionIcon({required Function onTap}) {
  return Material(
    shape: const CircleBorder(),
    elevation: 2.0, // Adjust the elevation to your preference
    child: CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: const Icon(Icons.question_mark),
        onPressed: () {
          onTap();
        },
      ),
    ),
  );
}
