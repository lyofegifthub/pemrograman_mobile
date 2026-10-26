
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../utils/currency_formatter.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() =>
      _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final dynamic argument = Get.arguments;

    if (argument is! Product) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Produk')),
        body: const Center(
          child: Text('Data produk tidak ditemukan.'),
        ),
      );
    }

    final Product product = argument;
    final String description =
        (product.description?.isNotEmpty ?? false)
            ? product.description!
            : 'Tidak ada deskripsi produk.';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: product.image.isEmpty
                  ? const Icon(
                      Icons.image_not_supported_outlined,
                      size: 72,
                      color: Colors.grey,
                    )
                  : Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image_outlined,
                          size: 72,
                          color: Colors.grey,
                        );
                      },
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              CurrencyFormatter.format(product.price),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE85D35),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: const Icon(
                    Icons.category_outlined,
                    size: 18,
                  ),
                  label: Text(product.category),
                ),
                if (product.rating != null)
                  Chip(
                    avatar: const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.amber,
                    ),
                    label: Text(
                      product.rating!.toStringAsFixed(1),
                    ),
                  ),
              ],
            ),
            if (product.shopName.isNotEmpty) ...[
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  child: Icon(Icons.storefront_outlined),
                ),
                title: const Text('Nama toko'),
                subtitle: Text(product.shopName),
              ),
            ],
            const SizedBox(height: 16),
            const Text(
              'Deskripsi Produk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Jumlah Pembelian',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton.outlined(
                  onPressed: quantity > 1
                      ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton.outlined(
                  onPressed: quantity < product.stock
                      ? () {
                          setState(() {
                            quantity++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.add),
                ),
                const Spacer(),
                Text(
                  'Stok: ${product.stock}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: product.stock <= 0
                    ? null
                    : () {
                        if (!Get.isRegistered<CartController>()) {
                          Get.snackbar(
                            'Keranjang belum siap',
                            'CartController belum didaftarkan.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }

                        final cartController =
                            Get.find<CartController>();

                        cartController.addToCart(
                          product,
                          quantity: quantity,
                        );

                        Get.back();

                        Get.snackbar(
                          'Berhasil',
                          '$quantity ${product.name} ditambahkan ke keranjang.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text(
                  'Tambah ke Keranjang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (product.marketplaceUrl.isNotEmpty) ...[
              const SizedBox(height: 10),
              const Text(
                'Harga dan ketersediaan dari marketplace dapat berubah.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
