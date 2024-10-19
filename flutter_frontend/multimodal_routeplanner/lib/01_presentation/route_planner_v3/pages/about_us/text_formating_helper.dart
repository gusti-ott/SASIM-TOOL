import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:url_launcher/url_launcher.dart';

Widget newlineSpacer = mediumVerticalSpacer;

Widget titleText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: primaryColorV3),
    textAlign: TextAlign.left,
  );
}

Widget headline1Text(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: primaryColorV3),
    textAlign: TextAlign.left,
  );
}

Widget headline2Text(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: primaryColorV3),
    textAlign: TextAlign.left,
  );
}

Widget bodyText(BuildContext context, String text, {bool isBold = false}) {
  return Text(
    text,
    style: Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: primaryColorV3, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    textAlign: TextAlign.left,
  );
}

Widget buildFormattedText(
  BuildContext context, {
  required String text,
  TextStyle? defaultStyle,
  List<FormatOption> formatOptions = const [],
}) {
  // If no default style is provided, use the body text style
  defaultStyle ??= Theme.of(context).textTheme.bodyLarge!.copyWith(color: primaryColorV3);

  // Sort format options by the index they appear in the text
  if (formatOptions.isEmpty) {
    return Text(text, style: defaultStyle);
  }
  formatOptions.sort((a, b) => text.indexOf(a.text).compareTo(text.indexOf(b.text)));

  List<TextSpan> textSpans = [];
  int lastIndex = 0;
  Set<String> formattedWords = {}; // Track words that have already been formatted

  for (final option in formatOptions) {
    String target = option.text;
    bool isBold = option.isBold;
    String? hyperlink = option.hyperlink;

    // Only format the first occurrence of each target word
    if (formattedWords.contains(target)) {
      continue; // Skip if this word has already been formatted
    }

    int startIndex = text.indexOf(target, lastIndex);

    if (startIndex != -1) {
      // Add the part of the text before the target string
      if (startIndex > lastIndex) {
        textSpans.add(TextSpan(
          text: text.substring(lastIndex, startIndex),
          style: defaultStyle,
        ));
      }

      // Determine the style for the target text
      TextStyle targetStyle = isBold ? defaultStyle.copyWith(fontWeight: FontWeight.bold) : defaultStyle;

      // Add underline and matching underline color if the target is a hyperlink
      if (hyperlink != null) {
        const Color linkColor = Colors.blue;
        targetStyle = targetStyle.copyWith(
          decoration: TextDecoration.underline,
          color: linkColor, // Change the text color to blue
          decorationColor: linkColor, // Change the underline color to match the text
        );
      }

      // Create a TextSpan for the target string with styles
      textSpans.add(TextSpan(
        text: target,
        style: targetStyle,
        recognizer: hyperlink != null
            ? (TapGestureRecognizer()
              ..onTap = () async {
                _launchUrl(Uri.parse(hyperlink));
              })
            : null,
      ));

      // Mark this word as already formatted
      formattedWords.add(target);

      // Move lastIndex to the end of the current target
      lastIndex = startIndex + target.length;
    }
  }

  // Add any remaining text after the last formatted part
  if (lastIndex < text.length) {
    textSpans.add(TextSpan(
      text: text.substring(lastIndex),
      style: defaultStyle,
    ));
  }

  return RichText(
    text: TextSpan(children: textSpans),
  );
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class FormatOption {
  final String text;
  final bool isBold;
  final String? hyperlink;

  FormatOption(this.text, {this.isBold = false, this.hyperlink});
}
