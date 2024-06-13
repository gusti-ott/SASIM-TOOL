import 'package:flutter/material.dart';

Widget customQuestionIcon() {
  return CircleAvatar(
    radius: 14,
    backgroundColor: Colors.white,
    child: IconButton(
      padding: const EdgeInsets.all(0),
      icon: const Icon(Icons.question_mark),
      onPressed: () {},
    ),
  );
}
