

class Stock {
  final String symbol;
  final String company;
  final double price;
  final double changePercent;

  Stock({
    required this.symbol,
    required this.company,
    required this.price,
    required this.changePercent,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['ticker'] ?? '',
      company: json['name'] ?? '',
      price: (json['last'] ?? 0.0).toDouble(),
      changePercent: (json['pctChange'] ?? 0.0).toDouble(),
    );
  }
}

