import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Rubik',
  brightness: Brightness.dark,
  hintColor: Colors.white,
  shadowColor: const Color(0xfff7f7f7),
  primaryColor: const Color(0xFF03335D),
  primaryColorLight: const Color(0xfff7f7f7),
  highlightColor: const Color(0xFFFFFFFF),
  focusColor: const Color(0xFF8D8D8D),
  dividerColor: const Color(0xFF2A2A2A),
  canvasColor: const Color(0xFF041524),
  cardColor: const Color(0xFF263542),

  colorScheme : const ColorScheme.dark(primary: Color(0xFF64BDF9),
    secondary: Color(0xFF3B93DF),
    error:Color(0xFFCF6679),
    tertiary: Color(0xFF865C0A),
    tertiaryContainer: Color(0xFFB5CEF7),
    onTertiaryContainer: Color(0xFF35B3E7),
    primaryContainer: Color(0xFF208458),
    surface: Color(0xFF03335D),
    outline: Color(0xFF039D55),
    secondaryContainer: Color(0xFFF2F2F2),),



  textTheme:  const TextTheme(
    labelLarge: TextStyle(color: Color(0xFFF9FAFA)),
    displayLarge: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFFF9FAFA)),
    displayMedium: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFF9FAFA)),
    displaySmall: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFF9FAFA)),
    headlineMedium: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFF9FAFA)),
    headlineSmall: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFF9FAFA)),
    bodySmall: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFF9FAFA)),
    titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 12.0),
    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
);
