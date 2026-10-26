import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TokoKita',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Keranjang digunakan melalui BottomNavigationBar
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Produk',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Temukan produk terbaik untuk kebutuhanmu',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              '${dummyProducts.length} Produk',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                itemCount: dummyProducts.length,

                separatorBuilder: (
                  context,
                  index,
                ) {
                  return const SizedBox(
                    height: 12,
                  );
                },

                itemBuilder: (
                  context,
                  index,
                ) {
                  final product =
                      dummyProducts[index];

                  return GestureDetector(
                    onTap: () async {
                      final result =
                          await Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: product,
                      );

                      if (result is int &&
                          result > 0) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          SnackBar(
                            content: Text(
                              '$result item ditambahkan ke keranjang',
                            ),
                          ),
                        );
                      }
                    },

                    child: ProductCard(
                      product: product,
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