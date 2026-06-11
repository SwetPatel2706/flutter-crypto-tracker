import 'package:shared_preferences/shared_preferences.dart';

class WatchlistService {
  static const String _key = 'watchlist';

  Future<List<String>> getWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> toggleCoin(String coinId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchlist = prefs.getStringList(_key) ?? [];

    if (watchlist.contains(coinId)) {
      watchlist.remove(coinId);
    } else {
      watchlist.add(coinId);
    }
    await prefs.setStringList(_key, watchlist);
  }

  Future<bool> isInWatchlist(String coinId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.contains(coinId);
  }
}