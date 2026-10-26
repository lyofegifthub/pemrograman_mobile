import 'package:flutter/material.dart';

class StockBadge extends StatelessWidget {
  final String status;

  const StockBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color badgeColor;

    switch (status) {
      case 'Tersedia':
        badgeColor = Colors.green;
        break;

      case 'Stok Terbatas':
        badgeColor = Colors.orange;
        break;

      case 'Habis':
        badgeColor = Colors.red;
        break;

      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}