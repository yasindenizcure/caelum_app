import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/hava_durumu_model.dart';
import '../model/tahmin_model.dart';
import '../model/hava_kalitesi_model.dart';

class WeatherApiClient {
  static const String _apiAdresi = 'https://api.openweathermap.org/data/2.5';
  static const String _apiAnahtari = '7b313b5d9e8ec632b31dd871a50513d3';

  Future<HavaDurumuModel> getCurrentWeather(String city) async {
    if (city.isEmpty) {
      throw ArgumentError('City name cannot be empty');
    }

    try {
      final uri = Uri.parse(
        '$_apiAdresi/weather?q=$city&appid=$_apiAnahtari&units=metric&lang=tr',
      );

      final response = await http.get(uri);
      
      if (response.statusCode != 200) {
        throw HttpException('Failed to get weather data: ${response.statusCode}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      
      if (data.containsKey('error')) {
        throw Exception(data['error']['message']);
      }

      return HavaDurumuModel.fromJson(data);
    } on FormatException catch (e) {
      throw Exception('Failed to parse weather data: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get weather: $e');
    }
  }

  Future<List<TahminModel>> tahminGetir(String? sehir) async {
    if (sehir == null || sehir.isEmpty) {
      throw ArgumentError('Şehir adı boş olamaz');
    }

    try {
      final uri = Uri.parse(
        '$_apiAdresi/forecast?q=$sehir&appid=$_apiAnahtari&units=metric',
      );

      final yanit = await http.get(uri);
      
      if (yanit.statusCode != 200) {
        throw HttpException('Tahmin verileri alınamadı: ${yanit.statusCode}');
      }

      final veri = jsonDecode(yanit.body) as Map<String, dynamic>;
      final List<dynamic> tahminListesi = veri['list'];
      
      return tahminListesi.map((tahmin) => TahminModel.fromJson(tahmin)).toList();
    } catch (e) {
      throw Exception('Tahmin verileri alınamadı: $e');
    }
  }

  Future<HavaKalitesiModel> havaKalitesiGetir(double lat, double lon) async {
    try {
      final uri = Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$_apiAnahtari',
      );

      final yanit = await http.get(uri);
      
      if (yanit.statusCode != 200) {
        throw HttpException('Hava kalitesi verileri alınamadı: ${yanit.statusCode}');
      }

      final veri = jsonDecode(yanit.body) as Map<String, dynamic>;
      return HavaKalitesiModel.fromJson(veri);
    } catch (e) {
      throw Exception('Hava kalitesi verileri alınamadı: $e');
    }
  }

  Future<List<TahminModel>> getTahminler() async {
    final response = await http.get(Uri.parse(
      '$_apiAdresi/forecast?q=Istanbul&appid=$_apiAnahtari&units=metric&lang=tr'
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['list'] as List)
          .map((item) => TahminModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Tahmin verileri alınamadı');
    }
  }

  Future<HavaKalitesiModel> getHavaKalitesi() async {
    final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/air_pollution?lat=41.0082&lon=28.9784&appid=$_apiAnahtari'
    ));

    if (response.statusCode == 200) {
      return HavaKalitesiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Hava kalitesi verileri alınamadı');
    }
  }
}
