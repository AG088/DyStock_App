// main.dart

import 'package:flutter/material.dart';
import 'package:dynamic_stock_market_app/widgets/stock_list.dart'; // Update with your actual path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock App',
      theme: ThemeData.dark(),
      home: StockList(),
    );
  }
}


