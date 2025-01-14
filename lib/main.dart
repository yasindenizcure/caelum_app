import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/services/ayarlar_servisi.dart';
import 'package:weather_app_flutter/services/weather_api_client.dart';
import 'package:weather_app_flutter/controllers/hava_durumu_controller.dart';
import 'package:weather_app_flutter/utils/constanst.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weather_app_flutter/controllers/auth_controller.dart';
import 'package:weather_app_flutter/pages/giris_sayfasi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initServices();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caelum',
      theme: AppTheme.lightTheme,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const GirisSayfasi(),
    )
  );
}

Future<void> initServices() async {
  await Get.putAsync(() async {
    final servis = AyarlarServisi();
    await servis.ayarlariYukle();
    return servis;
  });
  Get.put(WeatherApiClient());
  Get.put(HavaDurumuController());
  Get.put(AuthController());
}

class HavaDurumuUygulamasi extends StatelessWidget {
  const HavaDurumuUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hava Durumu Uygulaması',
      theme: AppTheme.lightTheme,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const GirisSayfasi(),
    );
  }
}

