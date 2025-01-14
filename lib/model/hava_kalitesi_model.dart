class HavaKalitesiModel {
  final int aqi;
  final double pm25;
  final double pm10;
  final double co;
  final double o3;

  HavaKalitesiModel({
    required this.aqi,
    required this.pm25,
    required this.pm10,
    required this.co,
    required this.o3,
  });

  factory HavaKalitesiModel.fromJson(Map<String, dynamic> json) {
    final components = json['list'][0]['components'];
    return HavaKalitesiModel(
      aqi: json['list'][0]['main']['aqi'],
      pm25: components['pm2_5'].toDouble(),
      pm10: components['pm10'].toDouble(),
      co: components['co'].toDouble(),
      o3: components['o3'].toDouble(),
    );
  }
} 