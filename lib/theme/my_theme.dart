import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(elevation: 2),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(size: 30),
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.black,
    showUnselectedLabels: false,
  ),
);
ThemeData darkMode = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(elevation: 0),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(size: 30),
    unselectedItemColor: Colors.grey[500],
    selectedItemColor: Colors.white,
    showUnselectedLabels: false,
  ),
);
