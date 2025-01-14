import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Ekran boyutları
double get w => Get.width;
double get h => Get.height;

// Renk sabitleri
const kTextColor1 = Color.fromARGB(255, 255, 255, 255);
const kTextColor2 = Color.fromARGB(241, 212, 212, 212);

// Metin stilleri
const kTitleFont = TextStyle(
  fontSize: 30,
  color: Colors.white,
  fontWeight: FontWeight.w300,
);

const kTempFont = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 90,
);

const kMoreInfoFont = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w400,
);

class AppTheme {
  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

} 