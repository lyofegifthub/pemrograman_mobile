import 'package:flutter/material.dart';

class PriceLabel extends StatelessWidget {
  final double price;

  const PriceLabel({
    super.key,
    required this.price,
  });

  String _formatRupiah(double value) {
    final digits = value.toStringAsFixed(0);
    final reversed = digits.split('').reversed.toList();
    final parts = <String>[];

    for (int i = 0; i < reversed.length; i += 3) {
      final end =
          (i + 3 < reversed.length)
              ? i + 3
              : reversed.length;

      parts.add(
        reversed.sublist(i, end).reversed.join(),
      );
    }

    return 'Rp ${parts.reversed.join('.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatRupiah(price),
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}