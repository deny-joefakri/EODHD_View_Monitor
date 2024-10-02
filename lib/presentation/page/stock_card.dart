import 'package:eodhd_view_monitor/data/models/crypto_model.dart';
import 'package:flutter/material.dart';

import '../utils/general_view.dart';

class StockCard extends StatelessWidget {
  final CryptoModel crypto;
  final VoidCallback onTap;

  const StockCard({
    Key? key,
    required this.crypto,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: buildCryptoIcon(crypto.tickerCode),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto.tickerCode,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      getCryptoFullName(crypto.tickerCode),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${crypto.lastPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Chg ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${crypto.dailyDifferencePrice.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: crypto.dailyDifferencePrice >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Chg%',
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${crypto.dailyChangePercentage.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: crypto.dailyChangePercentage >= 0 ? Colors.green : Colors.red,
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
