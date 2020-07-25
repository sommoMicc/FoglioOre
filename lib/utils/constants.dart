import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> MESI = [
  "GENNAIO",
  "FEBBRAIO",
  "MARZO",
  "APRILE",
  "MAGGIO",
  "GIUGNO",
  "LUGLIO",
  "AGOSTO",
  "SETTEMBRE",
  "OTTOBRE",
  "NOVEMBRE",
  "DICEMBRE"
];

class AppColors {
  static const Color primary = Color(0xFF0C6626);
  static const Color accent = Color(0xFFF08F37);

  static const Color defaultBackground = Colors.white;
  static const Color defaultText = Color(0xFF636871);

  static const Color circleIconButtonBackground = accent;
  static const Color circleIconButtonColor = Colors.white;

  static final List<CardColor> cardColors = [
    CardColor(
      border: const Color(0xFF006665),
      background: const Color(0xFFF0F8F8),
    ),
    CardColor(
      border: const Color(0xFFFF8267),
      background: const Color(0xFFFFF6F4),
    ),
  ];
}

class CardColor {
  Color border, background;
  CardColor({this.border, this.background});
}

const double kDefaultPadding = 8.0;
const double kDefaultRadius = 8.0;

final TextStyle kLabelTextStyle =
    TextStyle(fontSize: kLabelFontSize, color: AppColors.defaultText);

final TextTheme kDefaultTextTheme = GoogleFonts.firaSansTextTheme(
  ThemeData.light().textTheme.copyWith(
      bodyText1: TextStyle(
        color: AppColors.defaultText,
      ),
      headline6: TextStyle(color: AppColors.defaultText)),
);

const double kAppBarFontSize = 20.0;
const double kAppBarElevation = 1.0;

const double kLabelFontSize = 19.0;
const double kCardTitleSize = 15.0;

const double kCircularButtonWidth = 38.0;
