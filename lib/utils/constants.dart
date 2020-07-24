import 'package:flutter/material.dart';

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
  static final Color primary = Color(0xFF0C6626);
  static final Color accent = Color(0xFFF08F37);

  static final Color defaultBackground = Colors.white;
  static final Color defaultText = Color(0xFF636871);

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

const double kLabelFontSize = 19.0;
const double kCardTitleSize = 15.0;
