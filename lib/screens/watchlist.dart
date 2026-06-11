import 'package:flutter/material.dart';
import '../models/coin.dart';
import '../services/api_service.dart';
import '../services/watchlist_service.dart';
import '../widgets/coin_tile.dart';
// import '../core/theme.dart';
import 'asset_details.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late Future<List<Coin>> _watchlistFuture;

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  void _loadWatchlist() {
    setState(() {
      _watchlistFuture = _fetchWatchlistedCoins();
    });
  }

  Future<List<Coin>> _fetchWatchlistedCoins() async {
    final allCoins = await ApiService().getCoins();
    final savedIds = await WatchlistService().getWatchlist();
    return allCoins.where((coin) => savedIds.contains(coin.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Watchlist")),
      body: FutureBuilder<List<Coin>>(
        future: _watchlistFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star_border, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Your watchlist is empty", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return CoinTile(
                coin: snapshot.data![index],
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (_) => AssetDetailsScreen(coin: snapshot.data![index])));
                  _loadWatchlist(); // Refresh when coming back
                },
              );
            },
          );
        },
      ),
    );
  }
}