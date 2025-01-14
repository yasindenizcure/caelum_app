import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/pages/ayarlar_sayfasi.dart';
import 'package:weather_app_flutter/pages/hava_kalitesi_sayfasi.dart';
import 'package:weather_app_flutter/pages/tahmin_sayfasi.dart';
import '../controllers/hava_durumu_controller.dart';
import '../widgets/mevcut_hava_durumu_widget.dart';
import '../widgets/detay_bilgiler_widget.dart';
import '../controllers/auth_controller.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _seciliSayfa = 0;
  final _aramaController = TextEditingController();
  final _controller = Get.find<HavaDurumuController>();
  
  final List<Widget> _sayfalar = [
    const GuncelHavaDurumuSayfasi(),
    const TahminSayfasi(),
    const HavaKalitesiSayfasi(),
    const AyarlarSayfasi(),
  ];

  @override
  void initState() {
    super.initState();
    _controller.veriGetir('Istanbul');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _aramaController,
          decoration: InputDecoration(
            hintText: 'Şehir ara...'.tr,
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _controller.veriGetir(value);
            }
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Get.find<AuthController>().cikisYap(),
          ),
        ],
      ),
      body: _sayfalar[_seciliSayfa],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _seciliSayfa,
          onTap: (index) => setState(() => _seciliSayfa = index),
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.cloud),
              label: 'Hava Durumu'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today),
              label: 'Tahmin'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.air),
              label: 'Hava Kalitesi'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'Ayarlar'.tr,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _aramaController.dispose();
    super.dispose();
  }
}

class GuncelHavaDurumuSayfasi extends StatelessWidget {
  const GuncelHavaDurumuSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HavaDurumuController>();

    return Obx(() {
      if (controller.yukleniyor.value) {
        return const Center(child: CircularProgressIndicator(color: Colors.white));
      }

      final hava = controller.havaDurumu.value;
      if (hava == null) {
        return Center(
          child: Text(
            'Veri bulunamadı'.tr,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              mevcutHavaDurumu(
                yenile: () => controller.veriGetir(hava.sehirAdi),
                sicaklik: controller.sicaklikDonustur(hava.sicaklik),
                sehir: hava.sehirAdi,
                ulke: hava.ulke,
                durum: hava.durum,
              ),
              const SizedBox(height: 20),
              detayBilgiler(
                ruzgar: "${hava.ruzgar}",
                basinc: "${hava.basinc}",
                nem: "${hava.nem}",
                hissedilen: controller.sicaklikDonustur(hava.hissedilen),
              ),
            ],
          ),
        ),
      );
    });
  }
} 