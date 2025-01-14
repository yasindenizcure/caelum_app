import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget detayBilgiler({
  required String ruzgar,
  required String basinc,
  required String nem,
  required String hissedilen,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _detaySatir(
            icon: Icons.air,
            baslik: 'Rüzgar'.tr,
            deger: '$ruzgar m/s',
          ),
          const Divider(),
          _detaySatir(
            icon: Icons.compress,
            baslik: 'Basınç'.tr,
            deger: '$basinc hPa',
          ),
          const Divider(),
          _detaySatir(
            icon: Icons.water_drop,
            baslik: 'Nem'.tr,
            deger: '%$nem',
          ),
          const Divider(),
          _detaySatir(
            icon: Icons.thermostat,
            baslik: 'Hissedilen'.tr,
            deger: '$hissedilen°',
          ),
        ],
      ),
    ),
  );
}

Widget _detaySatir({
  required IconData icon,
  required String baslik,
  required String deger,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(baslik),
          ],
        ),
        Text(
          deger,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
} 