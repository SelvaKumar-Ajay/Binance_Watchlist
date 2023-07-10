import 'dart:async';

import 'package:flutter/material.dart';

import 'data/watchlist.dart';
import 'model/crypto_model.dart';
import 'utils/util_functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WatchlistScreen(),
    );
  }
}

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  Timer? _timer;
  late List<Crypto> watchlist;
  // double price = 0;
  // double priceChange = 0;
  @override
  void initState() {
    super.initState();
    watchlist = WatchListData.watchlist;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updatePrices();
    });
  }

  // ignore: unused_element
  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _updatePrices() {
    setState(() {
      for (var item in watchlist) {
        item.price = generateRandomPrice();
        item.priceChange = generateRandomPriceChange();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: ListView.builder(
        itemCount: watchlist.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.black45,
            margin: const EdgeInsets.only(top: 4),
            child: ListTile(
              leading: Icon(
                  watchlist[index].favorite
                      ? Icons.star
                      : Icons.star_border_outlined,
                  color:
                      watchlist[index].favorite ? Colors.yellow : Colors.grey),
              title: Row(
                children: [
                  Icon(
                    watchlist[index].icon,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        watchlist[index].name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        watchlist[index].shortName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${watchlist[index].price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        watchlist[index].priceChange >= 0
                            ? const Icon(Icons.arrow_circle_up_outlined,
                                size: 12, color: Colors.green)
                            : const Icon(Icons.arrow_circle_down_outlined,
                                size: 12, color: Colors.red),
                        const SizedBox(width: 4),
                        Text(
                          '%${watchlist[index].priceChange.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: watchlist[index].priceChange >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
