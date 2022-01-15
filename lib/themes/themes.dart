// ignore_for_file: deprecated_member_use, unnecessary_const

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff5e3c58); //muted dark purple
const kPrimaryDark = Color(0xff260036); //head: dark purple
const kPrimaryLight = Color(0xffeae4F8); //muted light

const kSecondaryColor = Color(0xffb39ddb);
const kSecondaryDark = Color(0xff371f41); //light indo purple
const kSecondaryLight = Color(0xffa78bbb); //light

class Dark {
  final ThemeData theme = ThemeData(
      accentColor: kPrimaryDark,
      scaffoldBackgroundColor: Colors.deepPurple[50],
      appBarTheme: const AppBarTheme(
        backgroundColor: kSecondaryDark,
      ),
      inputDecorationTheme: const InputDecorationTheme(
          hintStyle: const TextStyle(color: kSecondaryLight),
          fillColor: const Color.fromRGBO(255, 255, 255, 0.05)),
      dialogTheme: const DialogTheme(
          backgroundColor: kSecondaryDark,
          titleTextStyle: const TextStyle(color: kSecondaryLight, fontSize: 18),
          contentTextStyle:
              const TextStyle(color: Colors.white, fontSize: 16)));
}
