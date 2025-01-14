import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/ana_sayfa.dart';
import '../pages/giris_sayfasi.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  final _yukleniyor = false.obs;
  
  User? get kullanici => _firebaseUser.value;
  bool get yukleniyor => _yukleniyor.value;
  bool get kullaniciVar => _firebaseUser.value != null;
  
  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
    ever(_firebaseUser, _kullaniciDurumuKontrol);
  }

  void _kullaniciDurumuKontrol(User? kullanici) {
    if (kullanici != null) {
      Get.offAll(() => const AnaSayfa());
    }
  }

  Future<void> kayitOl(String email, String sifre) async {
    try {
      _yukleniyor.value = true;
      final UserCredential sonuc = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: sifre,
      );
      if (sonuc.user != null) {
        Get.defaultDialog(
          title: 'Başarılı',
          middleText: 'Başarıyla kayıt oldunuz.\nŞimdi giriş yapabilirsiniz.',
          textConfirm: 'Tamam',
          confirmTextColor: Colors.white,
          onConfirm: () => Get.back(),
          barrierDismissible: false,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Hata',
        _hataMesajiCevir(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _yukleniyor.value = false;
    }
  }

  Future<void> girisYap(String email, String sifre) async {
    try {
      _yukleniyor.value = true;
      print('Giriş denemesi: $email'); // Debug için log

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: sifre,
      );

      if (userCredential.user != null) {
        print('Giriş başarılı: ${userCredential.user!.uid}');
        Get.offAll(() => AnaSayfa()); // veya hedef sayfanız
      } else {
        print('Giriş başarısız: Kullanıcı null');
        Get.snackbar(
          'Hata',
          'Giriş yapılamadı',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    } on FirebaseAuthException catch (e) {
      print('Firebase Giriş Hatası: ${e.code} - ${e.message}');
      Get.snackbar(
        'Hata',
        _hataMesajiCevir(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Genel Giriş Hatası: $e');
      Get.snackbar(
        'Hata',
        'Beklenmeyen bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _yukleniyor.value = false;
    }
  }

  Future<void> cikisYap() async {
    await _auth.signOut();
    Get.offAll(() => GirisSayfasi());
  }

  String _hataMesajiCevir(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Kullanıcı bulunamadı';
      case 'wrong-password':
        return 'Hatalı şifre';
      case 'invalid-email':
        return 'Geçersiz e-posta adresi';
      case 'user-disabled':
        return 'Kullanıcı hesabı devre dışı';
      case 'too-many-requests':
        return 'Çok fazla giriş denemesi yapıldı. Lütfen daha sonra tekrar deneyin';
      default:
        return 'Giriş yapılamadı: ${e.message}';
    }
  }
} 