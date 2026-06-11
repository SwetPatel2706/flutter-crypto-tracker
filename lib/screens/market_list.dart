// lib/screens/market_list.dart
import 'package:flutter/material.dart';
import '../models/coin.dart';
import '../services/api_service.dart';
import '../widgets/coin_tile.dart';
import '../core/theme.dart';
import 'asset_details.dart';

class MarketListScreen extends StatefulWidget {
  const MarketListScreen({super.key});

  @override
  State<MarketListScreen> createState() => _MarketListScreenState();
}

class _MarketListScreenState extends State<MarketListScreen> {
  List<Coin> _allCoins = [];
  List<Coin> _filteredCoins = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final coins = await ApiService().getCoins();
      setState(() {
        _allCoins = coins;
        _filteredCoins = coins;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Coin> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allCoins;
    } else {
      results = _allCoins
          .where((coin) =>
              coin.name.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              coin.symbol.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() => _filteredCoins = results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markets", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                      hintText: 'Search coins...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: AppTheme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Coins List
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredCoins.length,
                      itemBuilder: (context, index) {
                        return CoinTile(
                          coin: _filteredCoins[index],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AssetDetailsScreen(coin: _filteredCoins[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}