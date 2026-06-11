// lib/core/constants.dart

class AppConstants {
  // CoinGecko API: Top 50 coins, USD, Sparkline enabled
  static const String baseUrl = 
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24h';
  
  // App Strings
  static const String appName = 'CryptoPulse';
}