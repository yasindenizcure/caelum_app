class HavaDurumuModel {
  final String sehirAdi;
  final String ulke;
  final double sicaklik;
  final double hissedilen;
  final String durum;
  final String aciklama;
  final double ruzgar;
  final int basinc;
  final int nem;
  final String icon;

  HavaDurumuModel({
    required this.sehirAdi,
    required this.ulke,
    required this.sicaklik,
    required this.hissedilen,
    required this.durum,
    required this.aciklama,
    required this.ruzgar,
    required this.basinc,
    required this.nem,
    required this.icon,
  });

  factory HavaDurumuModel.fromJson(Map<String, dynamic> json) {
    return HavaDurumuModel(
      sehirAdi: json['name'],
      ulke: json['sys']['country'],
      sicaklik: json['main']['temp'].toDouble(),
      hissedilen: json['main']['feels_like'].toDouble(),
      durum: json['weather'][0]['main'],
      aciklama: json['weather'][0]['description'],
      ruzgar: json['wind']['speed'].toDouble(),
      basinc: json['main']['pressure'],
      nem: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
    );
  }
} 