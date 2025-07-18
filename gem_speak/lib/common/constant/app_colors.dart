import 'package:flutter/material.dart';

abstract class AppColors {
  // Branch colors
  static const Color featherGreen = Color(0xFF58cc02);
  static const Color maskGreen = Color(0xFF89e219);
  static const Color snow = Color(0xFFffffff);

  // Secondary colors
  static const Color macaw = Color(0xff1cb0f6);
  static const Color cardinal = Color(0xffff4b4b);
  static const Color bee = Color(0xffffc800);

  static const Color fox = Color(0xffff9600);
  static const Color beetle = Color(0xffce82ff);
  static const Color humpback = Color(0xff2b70c9);

  // Neutrals
  static const Color eel = Color(0xff4b4b4b);
  static const Color wolf = Color(0xff777777);
  static const Color hare = Color(0xffafafaf);
  static const Color swan = Color(0xffe5e5e5);
  static const Color polar = Color(0xfff7f7f7);

  // Duo's Pallette
  static const Color wingOverlay = Color(0xff43c000);
  static const Color beakInnter = Color(0xffb66e28);
  static const Color beakLower = Color(0xfff49000);
  static const Color beakUpper = Color(0xfff7b000);
  static const Color beakHighlight = Color(0xffffde00);
  static const Color tonguePink = Color(0xffffcaff);
  static const Color greenShader = Color(0xff2d6700);

  static Color textColor = AppColors.greenShader.withValues(alpha: 0.9);
}
