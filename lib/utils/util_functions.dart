import 'dart:math';

import 'package:flutter/material.dart';

double generateRandomPrice() {
  final random = Random();
  return random.nextDouble() * 100000;
}

double generateRandomPriceChange() {
  final random = Random();
  return (random.nextDouble() * 10) - 5;
}

Color getFavoriteColor({required bool index}) {
  if (index) {
    return Colors.grey;
  } else {
    return Colors.yellow;
  }
}
