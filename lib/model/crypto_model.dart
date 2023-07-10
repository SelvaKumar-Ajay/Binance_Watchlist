import 'package:flutter/material.dart';

class Crypto {
  IconData icon;
  bool favorite;
  String name;
  String shortName;
  double price;
  double priceChange;
  Crypto({
    required this.icon,
    required this.favorite,
    required this.name,
    required this.shortName,
    required this.price,
    required this.priceChange,
  });
}
