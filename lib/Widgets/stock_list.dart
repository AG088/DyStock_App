// lib/widgets/stock_list.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dynamic_stock_market_app/Models/stock.dart';

class StockList extends StatefulWidget {
  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  List<Stock> stocks = [];
  bool isLoading = true;
  String errorMessage = '';


  List<Stock> predefinedStocks = [
    Stock(company: "Reliance Industries", symbol: "RELIANCE", price: 2380.00, changePercent: 1.2),
    Stock(company: "Tata Consultancy Services", symbol: "TCS", price: 3318.40, changePercent: -0.5),
    Stock(company: "HDFC Bank", symbol: "HDFCBANK", price: 1490.00, changePercent: 0.8),
    Stock(company: "Hindustan Unilever", symbol: "HINDUNILVR", price: 2454.00, changePercent: 0.3),
    Stock(company: "Infosys", symbol: "INFY", price: 1753.10, changePercent: 2.1),
    Stock(company: "ICICI Bank", symbol: "ICICIBANK", price: 673.05, changePercent: 1.4),
    Stock(company: "Bharti Airtel", symbol: "BHARTIARTL", price: 609.50, changePercent: -0.9),
    Stock(company: "Axis Bank", symbol: "AXISBANK", price: 749.80, changePercent: 1.0),
    Stock(company: "Kotak Mahindra Bank", symbol: "KOTAKBANK", price: 1846.20, changePercent: 0.7),
    Stock(company: "State Bank of India", symbol: "SBIN", price: 463.00, changePercent: 1.5),
  ];

  @override
  void initState() {
    super.initState();
    // Add predefined stocks initially
    stocks = predefinedStocks;
    _fetchStocks();
  }

  Future<void> _fetchStocks() async {
    try {
      // Example API endpoint
      final response = await http.get(
        Uri.parse('https://api.tiingo.com/iex?tickers=RELIANCE,TCS,HDFCBANK,HINDUNILVR,INFY,ICICIBANK,BHARTIARTL,AXISBANK,KOTAKBANK,SBIN&token=947a27b5b422305898bd132ee9d42c896587c2b2'),

      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Stock> fetchedStocks = jsonData.map((json) => Stock.fromJson(json)).toList();
        setState(() {
          stocks = fetchedStocks;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load stocks');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
      print('Error fetching stocks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : ListView.separated(
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${stock.symbol}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${stock.company}",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "\$${stock.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueAccent,
                          ),
                          width: 75,
                          height: 25,
                          alignment: Alignment.center,
                          child: Text(
                            "${stock.changePercent.toStringAsFixed(2)}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
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
