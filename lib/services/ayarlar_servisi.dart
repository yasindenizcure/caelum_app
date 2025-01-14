import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_flutter/utils/constanst.dart';

class AyarlarServisi extends GetxService {
  static const String _sicaklikBirimiKey = 'sicaklik_birimi';
  static const String _dilKey = 'dil';
  static const String _temaKey = 'tema';

  final _sicaklikBirimi = 'C'.obs;
  final _dil = 'tr'.obs;
  final _karanlikTema = false.obs;

  String get sicaklikBirimi => _sicaklikBirimi.value;
  String get dil => _dil.value;
  bool get karanlikTema => _karanlikTema.value;

  @override
  void onInit() {
    super.onInit();
    ayarlariYukle();
  }

  Future<void> ayarlariYukle() async {
    final prefs = await SharedPreferences.getInstance();
    _sicaklikBirimi.value = prefs.getString(_sicaklikBirimiKey) ?? 'C';
    _dil.value = prefs.getString(_dilKey) ?? 'tr';
    _karanlikTema.value = prefs.getBool(_temaKey) ?? false;
    
    Get.updateLocale(Locale(_dil.value));
    Get.changeThemeMode(_karanlikTema.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> sicaklikBirimiDegistir(String birim) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sicaklikBirimiKey, birim);
    _sicaklikBirimi.value = birim;
  }

  Future<void> dilDegistir(String yeniDil) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dilKey, yeniDil);
    Get.updateLocale(Locale(yeniDil));
    _dil.value = yeniDil;
  }

  Future<void> temaDegistir(bool karanlik) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_temaKey, karanlik);
    _karanlikTema.value = karanlik;
    Get.changeTheme(karanlik ? ThemeData.dark() : AppTheme.lightTheme);
  }
}