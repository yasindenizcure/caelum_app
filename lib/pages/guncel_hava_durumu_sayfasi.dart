import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hava_durumu_controller.dart';

class GuncelHavaDurumuSayfasi extends StatelessWidget {
  const GuncelHavaDurumuSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HavaDurumuController>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Güncel Hava Durumu'.tr),
      ),
      body: Obx(() {
        if (controller.yukleniyor.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return const Center(
          child: Text('Güncel hava durumu içeriği buraya gelecek'),
        );
      }),
    );
  }
}
