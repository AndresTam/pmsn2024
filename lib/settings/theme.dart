import 'package:flutter/material.dart';

class ThemeApp{
  static ThemeData lightTheme(context){
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color.fromARGB(255,255,0,0),
      )
    );
  }

  static ThemeData darkTheme(context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color.fromARGB(255,0,255,0),
      )
    );
  }
}