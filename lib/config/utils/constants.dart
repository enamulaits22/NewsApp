import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static ThemeData lightTheme = ThemeData.light(); 
  static ThemeData darkTheme = ThemeData.dark(); 
  
  //shared preferences keys
  static const themeKey = 'darkTheme'; 
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = 'b07ba3588381413091247463e6bce8aa';
}