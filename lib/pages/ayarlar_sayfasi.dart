import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/ayarlar_servisi.dart';

class AyarlarSayfasi extends StatelessWidget {
  const AyarlarSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final ayarlar = Get.find<AyarlarServisi>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'.tr),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Sıcaklık Birimi'.tr),
            subtitle: Obx(() => Text(
              ayarlar.sicaklikBirimi == 'C' ? 'Santigrat (°C)'.tr : 'Fahrenheit (°F)'.tr
            )),
            onTap: () => _sicaklikBirimiDegistirDiyalog(),
          ),
          ListTile(
            title: Text('Dil'.tr),
            subtitle: Obx(() => Text(
              ayarlar.dil == 'tr' ? 'Türkçe' : 'English'
            )),
            onTap: () => _dilDegistirDiyalog(),
          ),
          ListTile(
            title: Text('Tema'.tr),
            trailing: Obx(() => Switch(
              value: ayarlar.karanlikTema,
              onChanged: (value) => ayarlar.temaDegistir(value),
            )),
          ),
        ],
      ),
    );
  }

  void _sicaklikBirimiDegistirDiyalog() {
    final ayarlar = Get.find<AyarlarServisi>();
    
    Get.dialog(
      AlertDialog(
        title: Text('Sıcaklık Birimi Seç'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Santigrat (°C)'),
              leading: Radio(
                value: ayarlar.sicaklikBirimi == 'C',
                groupValue: true,
                onChanged: (value) {
                  if (value == true) {
                    ayarlar.sicaklikBirimiDegistir('C');
                    Get.back();
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Fahrenheit (°F)'),
              leading: Radio(
                value: ayarlar.sicaklikBirimi == 'F',
                groupValue: true,
                onChanged: (value) {
                  if (value == true) {
                    ayarlar.sicaklikBirimiDegistir('F');
                    Get.back();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dilDegistirDiyalog() {
    final ayarlar = Get.find<AyarlarServisi>();
    
    Get.dialog(
      AlertDialog(
        title: Text('Dil Seç'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Türkçe'),
              leading: Radio(
                value: ayarlar.dil == 'tr',
                groupValue: true,
                onChanged: (value) {
                  if (value == true) {
                    ayarlar.dilDegistir('tr');
                    Get.back();
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('English'),
              leading: Radio(
                value: ayarlar.dil == 'en',
                groupValue: true,
                onChanged: (value) {
                  if (value == true) {
                    ayarlar.dilDegistir('en');
                    Get.back();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 