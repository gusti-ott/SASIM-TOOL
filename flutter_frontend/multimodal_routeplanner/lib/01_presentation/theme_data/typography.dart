import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textTheme = TextTheme(
  displayLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 57,
    height: 64 / 57,
    letterSpacing: -0.25,
  ),
  displayMedium: GoogleFonts.barlow(
    fontWeight: FontWeight.w300,
    fontSize: 39,
    height: 49 / 39,
    letterSpacing: -0.88,
  ),
  displaySmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w300,
    fontSize: 28,
    height: 38 / 28,
    letterSpacing: -0.3,
  ),
  headlineLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 40 / 32,
  ),
  headlineMedium: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 36 / 32,
  ),
  headlineSmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 32 / 24,
  ),
  titleLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w300,
    fontSize: 22,
    height: 31 / 22,
    letterSpacing: -0.5,
  ),
  titleMedium: GoogleFonts.barlow(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
  ),
  labelLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 16 / 14,
    letterSpacing: -0.3,
  ),
  labelMedium: GoogleFonts.barlow(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.2,
  ),
  labelSmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 16 / 11,
  ),
  bodyLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.barlow(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
  ),
  bodySmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: -0.3,
  ),
);

final fontWhiteBold = textTheme.bodyMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold);

final scoreBarTextStyle = textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w800, fontSize: 19.07, height: 27.78);

// custom mobile fonts
final mobileSearchHeaderTextStyle =
    textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w300, fontSize: 26, height: 28 / 26, letterSpacing: -0.7);
final mobileSearchSubtitleTextStyle =
    GoogleFonts.barlow(fontWeight: FontWeight.w300, fontSize: 14, height: 18 / 14, letterSpacing: -0.5);
final mobileChipLabelTextStyle =
    GoogleFonts.barlow(fontWeight: FontWeight.w500, fontSize: 12.44, height: 17.77 / 12, letterSpacing: 0.09);
final mobileElectricSwitchLabelTextStyle =
    GoogleFonts.barlow(fontWeight: FontWeight.w400, fontSize: 11.47, height: 16.38 / 11.47, letterSpacing: 0.08);

final mapLegendTextStyle =
    GoogleFonts.barlow(fontWeight: FontWeight.w400, fontSize: 14, height: 18 / 14, letterSpacing: 0.1);

final mobiScoreLetterStyle =
    GoogleFonts.barlow(fontWeight: FontWeight.w800, fontSize: 19.07, height: 27.78 / 19.07, letterSpacing: 0);
