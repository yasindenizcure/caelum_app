import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_flutter/main.dart';

void main() {
  testWidgets('Test uygulama başlangıcı', (WidgetTester tester) async {
    await tester.pumpWidget(const HavaDurumuUygulamasi());
  });
}
