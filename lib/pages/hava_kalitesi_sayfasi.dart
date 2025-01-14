import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hava_durumu_controller.dart';

class HavaKalitesiSayfasi extends StatelessWidget {
  const HavaKalitesiSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HavaDurumuController>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Hava Kalitesi'.tr),
      ),
      body: Obx(() {
        if (controller.yukleniyor.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final kalite = controller.havaKalitesi.value;
        if (kalite == null) {
          return Center(child: Text('Hava kalitesi verisi bulunamadı'.tr));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _KaliteGostergesi(aqi: kalite.aqi),
              const SizedBox(height: 32),
              _KaliteBilgisi(
                baslik: 'PM2.5',
                deger: kalite.pm25,
                birim: 'µg/m³',
              ),
              _KaliteBilgisi(
                baslik: 'PM10',
                deger: kalite.pm10,
                birim: 'µg/m³',
              ),
              _KaliteBilgisi(
                baslik: 'CO',
                deger: kalite.co,
                birim: 'µg/m³',
              ),
              _KaliteBilgisi(
                baslik: 'O₃',
                deger: kalite.o3,
                birim: 'µg/m³',
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _KaliteGostergesi extends StatelessWidget {
  final int aqi;

  const _KaliteGostergesi({required this.aqi});

  Color _rengiGetir() {
    switch (aqi) {
      case 1: return Colors.green;
      case 2: return Colors.yellow;
      case 3: return Colors.orange;
      case 4: return Colors.red;
      case 5: return Colors.purple;
      default: return Colors.grey;
    }
  }

  String _durumGetir() {
    switch (aqi) {
      case 1: return 'İyi'.tr;
      case 2: return 'Orta'.tr;
      case 3: return 'Hassas Gruplar İçin Sağlıksız'.tr;
      case 4: return 'Sağlıksız'.tr;
      case 5: return 'Çok Sağlıksız'.tr;
      default: return 'Bilinmiyor'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _rengiGetir().withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            _durumGetir(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'AQI: $aqi',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _KaliteBilgisi extends StatelessWidget {
  final String baslik;
  final double deger;
  final String birim;

  const _KaliteBilgisi({
    required this.baslik,
    required this.deger,
    required this.birim,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            baslik,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            '$deger $birim',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}