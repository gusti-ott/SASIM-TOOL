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
    fontWeight: FontWeight.w400,
    fontSize: 45,
    height: 52 / 45,
  ),
  displaySmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 36,
    height: 44 / 36,
  ),
  headlineLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 40 / 32,
  ),
  headlineMedium: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 28,
    height: 36 / 28,
  ),
  headlineSmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 32 / 24,
  ),
  titleLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 28 / 22,
  ),
  titleMedium: GoogleFonts.barlow(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
  ),
  labelLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
  ),
  labelMedium: GoogleFonts.barlow(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.5,
  ),
  labelSmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: 0.5,
  ),
  bodyLarge: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.barlow(fontWeight: FontWeight.w400, fontSize: 14, height: 20 / 14, letterSpacing: 0.25),
  bodySmall: GoogleFonts.barlow(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.4,
  ),
);

final fontWhiteBold = textTheme.bodyMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold);
