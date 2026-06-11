// lib/models/coin.dart

class Coin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final double high24h;
  final double low24h;
  final double marketCap;
  final double totalVolume;
  final double circulatingSupply;
  final List<double> sparklineIn7d;

  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.high24h,
    required this.low24h,
    required this.marketCap,
    required this.totalVolume,
    required this.circulatingSupply,
    required this.sparklineIn7d,
  });

factory Coin.fromJson(Map<String, dynamic> json) {
  return Coin(
    // ... keep your other fields the same ...
    id: json['id'],
    symbol: json['symbol'].toString().toUpperCase(),
    name: json['name'],
    image: json['image'],
    currentPrice: (json['current_price'] ?? 0).toDouble(),
    priceChange24h: (json['price_change_24h'] ?? 0).toDouble(),
    priceChangePercentage24h: (json['price_change_percentage_24h'] ?? 0).toDouble(),
    high24h: (json['high_24h'] ?? 0).toDouble(),
    low24h: (json['low_24h'] ?? 0).toDouble(),
    marketCap: (json['market_cap'] ?? 0).toDouble(),
    totalVolume: (json['total_volume'] ?? 0).toDouble(),
    circulatingSupply: (json['circulating_supply'] ?? 0).toDouble(),
    
    // THE FIX: Explicitly cast each element to double
    sparklineIn7d: (json['sparkline_in_7d']['price'] as List<dynamic>)
        .map((e) => (e as num).toDouble()) 
        .toList(),
  );
}
}