import 'package:flutter/material.dart';

Widget mevcutHavaDurumu({
  required VoidCallback yenile,
  required String sicaklik,
  String? sehir,
  String? ulke,
  String? durum,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$sehir, ${ulke ?? ""}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (durum != null)
                    Text(
                      durum,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: yenile,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '$sicaklik°',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
} 