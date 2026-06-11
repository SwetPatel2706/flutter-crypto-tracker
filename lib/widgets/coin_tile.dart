// lib/widgets/coin_tile.dart
import 'package:flutter/material.dart';
import '../models/coin.dart';
import '../core/theme.dart';

class CoinTile extends StatelessWidget {
  final Coin coin;
  final VoidCallback onTap;

  const CoinTile({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isPositive = coin.priceChangePercentage24h >= 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // 1. Image
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(coin.image)),
              ),
            ),
            const SizedBox(width: 12),
            
            // 2. Name & Symbol
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    coin.symbol,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),

            // 3. Price & Change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${coin.currentPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: isPositive ? AppTheme.greenColor : AppTheme.redColor,
                      size: 20,
                    ),
                    Text(
                      "${coin.priceChangePercentage24h.toStringAsFixed(2)}%",
                      style: TextStyle(
                        color: isPositive ? AppTheme.greenColor : AppTheme.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}