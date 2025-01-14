import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final _emailController = TextEditingController();
  final _sifreController = TextEditingController();
  final _authController = Get.find<AuthController>();
  bool _kayitModu = false;

  Future<void> _kayitOl() async {
    await _authController.kayitOl(
      _emailController.text,
      _sifreController.text,
    ).then((_) {
      // Başarılı kayıt sonrası
      Get.defaultDialog(
        title: 'Başarılı',
        middleText: 'Başarıyla kayıt oldunuz.\n Hoşgeldiniz..',
        textConfirm: 'Tamam',
        confirmTextColor: Colors.white,
        backgroundColor: Colors.green[100],
        titleStyle: const TextStyle(color: Colors.green),
        middleTextStyle: const TextStyle(color: Colors.black87),
        buttonColor: Colors.green,
        onConfirm: () {
          Get.back(); // Dialog'u kapat
          setState(() {
            _kayitModu = false; // Giriş moduna geç
            _emailController.clear(); // Email alanını temizle
            _sifreController.clear(); // Şifre alanını temizle
          });
        },
        barrierDismissible: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Caelum',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 48),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'E-posta'.tr,
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _sifreController,
                    hintText: 'Şifre'.tr,
                    icon: Icons.lock,
                    gizli: true,
                  ),
                  const SizedBox(height: 32),
                  _buildGirisButonu(),
                  const SizedBox(height: 16),
                  _buildKayitButonu(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool gizli = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: gizli,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildGirisButonu() {
    return Obx(() => ElevatedButton(
      onPressed: _authController.yukleniyor
          ? null
          : () {
              if (_kayitModu) {
                _kayitOl();
              } else {
                _authController.girisYap(
                  _emailController.text,
                  _sifreController.text,
                );
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _authController.yukleniyor
          ? const CircularProgressIndicator()
          : Text(
              _kayitModu ? 'Kayıt Ol'.tr : 'Giriş Yap'.tr,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    ));
  }

  Widget _buildKayitButonu() {
    return TextButton(
      onPressed: () {
        setState(() {
          _kayitModu = !_kayitModu;
        });
      },
      child: Text(
        _kayitModu
            ? 'Zaten hesabınız var mı? Giriş yapın'.tr
            : 'Hesabınız yok mu? Kayıt olun'.tr,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _sifreController.dispose();
    super.dispose();
  }
} 