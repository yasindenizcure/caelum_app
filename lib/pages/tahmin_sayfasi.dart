import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/hava_durumu_controller.dart';
import '../model/tahmin_model.dart';

class TahminSayfasi extends StatelessWidget {
  const TahminSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HavaDurumuController>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('5 Günlük Tahmin'.tr),
      ),
      body: Obx(() {
        if (controller.yukleniyor.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.tahminler.isEmpty) {
          return Center(child: Text('Tahmin verisi bulunamadı'.tr));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.tahminler.length,
          itemBuilder: (context, index) {
            final tahmin = controller.tahminler[index];
            return TahminKarti(tahmin: tahmin);
          },
        );
      }),
    );
  }
}

class TahminKarti extends StatelessWidget {
  final TahminModel tahmin;

  const TahminKarti({required this.tahmin, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, d MMMM', Get.locale?.languageCode)
                  .format(tahmin.tarih),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('En Yüksek: ${tahmin.maxSicaklik.toStringAsFixed(1)}°'),
                    Text('En Düşük: ${tahmin.minSicaklik.toStringAsFixed(1)}°'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Yağış: ${tahmin.yagisOlasiligi.toStringAsFixed(0)}%'),
                    Text('Rüzgar: ${tahmin.ruzgarHizi.toStringAsFixed(1)} m/s'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 