import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/coin.dart';
import '../core/theme.dart';
import '../core/utils.dart'; // Ensure utils are imported
import '../services/watchlist_service.dart'; // Ensure service is imported

class AssetDetailsScreen extends StatefulWidget {
  final Coin coin;
  const AssetDetailsScreen({super.key, required this.coin});

  @override
  State<AssetDetailsScreen> createState() => _AssetDetailsScreenState();
}

class _AssetDetailsScreenState extends State<AssetDetailsScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  // Check if coin is in SharedPreferences
  void _checkFavoriteStatus() async {
    bool exists = await WatchlistService().isInWatchlist(widget.coin.id);
    setState(() => _isFavorite = exists);
  }

  // Toggle favorite status
  void _toggleFavorite() async {
    await WatchlistService().toggleCoin(widget.coin.id);
    setState(() => _isFavorite = !_isFavorite);
    
    // Simple feedback
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isFavorite ? "Added to Watchlist" : "Removed from Watchlist"),
          duration: const Duration(milliseconds: 800),
          backgroundColor: AppTheme.cardColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPositive = widget.coin.priceChangePercentage24h >= 0;

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        title: Text(widget.coin.name),
        actions: [
            // Optional: You can put a share icon here
            IconButton(onPressed: (){}, icon: const Icon(Icons.ios_share))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Price Header
            Text(widget.coin.symbol, style: const TextStyle(fontSize: 18, color: Colors.grey)),
            Text(
              AppUtils.formatPrice(widget.coin.currentPrice), // Formatted Price
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              "${isPositive ? '+' : ''}${widget.coin.priceChangePercentage24h.toStringAsFixed(2)}% (24h)",
              style: TextStyle(color: isPositive ? AppTheme.greenColor : AppTheme.redColor, fontSize: 16),
            ),
            
            const SizedBox(height: 40),

            // 2. Chart Section
            SizedBox(
              height: 250,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: widget.coin.sparklineIn7d.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                      isCurved: true,
                      color: isPositive ? AppTheme.greenColor : AppTheme.redColor,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: (isPositive ? AppTheme.greenColor : AppTheme.redColor).withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 3. Stats Grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("Market Cap", AppUtils.formatVolume(widget.coin.marketCap)),
                _buildStatCard("Volume (24h)", AppUtils.formatVolume(widget.coin.totalVolume)),
              ],
            ),
            const SizedBox(height: 16),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("High (24h)", AppUtils.formatPrice(widget.coin.high24h)),
                _buildStatCard("Low (24h)", AppUtils.formatPrice(widget.coin.low24h)),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // 4. Watchlist Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFavorite ? Colors.grey[800] : AppTheme.primaryAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: _toggleFavorite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_isFavorite ? Icons.star : Icons.star_border, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      _isFavorite ? "Remove from Watchlist" : "Add to Watchlist",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Helper widget for the Grid Stats
  Widget _buildStatCard(String title, String value) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}