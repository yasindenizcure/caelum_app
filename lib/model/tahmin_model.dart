class TahminModel {
  final DateTime tarih;
  final double maxSicaklik;
  final double minSicaklik;
  final String durum;
  final double yagisOlasiligi;
  final double ruzgarHizi;

  TahminModel({
    required this.tarih,
    required this.maxSicaklik,
    required this.minSicaklik,
    required this.durum,
    required this.yagisOlasiligi,
    required this.ruzgarHizi,
  });

  factory TahminModel.fromJson(Map<String, dynamic> json) {
    return TahminModel(
      tarih: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      maxSicaklik: json['main']['temp_max'].toDouble(),
      minSicaklik: json['main']['temp_min'].toDouble(),
      durum: json['weather'][0]['main'],
      yagisOlasiligi: (json['pop'] * 100).toDouble(),
      ruzgarHizi: json['wind']['speed'].toDouble(),
    );
  }
} 