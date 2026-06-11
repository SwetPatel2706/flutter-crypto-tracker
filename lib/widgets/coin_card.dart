// lib/widgets/coin_card.dart
import 'package:flutter/material.dart';
import '../models/coin.dart';
import '../core/theme.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;
  final VoidCallback onTap;

  const CoinCard({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isPositive = coin.priceChangePercentage24h >= 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(coin.image, height: 30, width: 30),
                const Spacer(),
                Text(
                  coin.symbol,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "\$${coin.currentPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: isPositive ? AppTheme.greenColor : AppTheme.redColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "${coin.priceChangePercentage24h.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: isPositive ? AppTheme.greenColor : AppTheme.redColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}