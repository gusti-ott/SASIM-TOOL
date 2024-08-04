import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget addressInputField(
  BuildContext context, {
  required TextEditingController controller,
  required String hintText,
  required ValueChanged<String> onChanged,
  required bool isMobile,
  String? Function(String?)? validator,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    decoration: customBoxDecorationWithShadow(),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        suffixIcon: Icon(Icons.location_on, color: tertiaryColorV3, fill: 0.5),
        hintText: hintText,
        hintStyle: textTheme.labelMedium!.copyWith(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none, // No visible border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent), // Transparent border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: secondaryColorV3), // Border when the TextField is focused
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      ),
      onChanged: onChanged,
      maxLines: 1, // Ensure single-line input
      textInputAction: TextInputAction.done, // Handle done action on keyboard
      style: textTheme.labelMedium, // Style the text
      // Ensure text scrolls to the end when focused
      keyboardType: TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
    ),
  );
}
