import 'package:get/get.dart';
import '../model/tahmin_model.dart';
import '../model/hava_kalitesi_model.dart';
import '../services/weather_api_client.dart';
import '../model/hava_durumu_model.dart';

class HavaDurumuController extends GetxController {
  final WeatherApiClient _apiClient = WeatherApiClient();
  final yukleniyor = true.obs;
  final havaKalitesi = Rx<HavaKalitesiModel?>(null);
  final tahminler = RxList<TahminModel>([]);
  final havaDurumu = Rxn<HavaDurumuModel>();

  @override
  void onInit() {
    super.onInit();
    verileriYukle();
  }

  Future<void> verileriYukle() async {
    yukleniyor.value = true;
    try {
      final kalite = await _apiClient.getHavaKalitesi();
      havaKalitesi.value = kalite;
      
      final tahminListesi = await _apiClient.getTahminler();
      tahminler.value = tahminListesi;
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Veriler yüklenirken bir hata oluştu: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      yukleniyor.value = false;
    }
  }

  Future<void> veriGetir(String? sehir) async {
    if (sehir == null || sehir.isEmpty) return;
    
    yukleniyor.value = true;
    try {
      final hava = await _apiClient.getCurrentWeather(sehir);
      havaDurumu.value = hava;
      
      final kalite = await _apiClient.getHavaKalitesi();
      havaKalitesi.value = kalite;
      
      final tahminListesi = await _apiClient.getTahminler();
      tahminler.value = tahminListesi;
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Veriler yüklenirken bir hata oluştu: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      yukleniyor.value = false;
    }
  }

  String sicaklikDonustur(double? sicaklik) {
    if (sicaklik == null) return '0';
    return sicaklik.toStringAsFixed(1);
  }
}
