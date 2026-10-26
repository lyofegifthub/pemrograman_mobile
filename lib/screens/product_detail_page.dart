import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/price_label.dart';
import '../widgets/category_tag.dart';
import '../widgets/stock_badge.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() {
    return _ProductDetailPageState();
  }
}

class _ProductDetailPageState
    extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments
            as Product;

    final description =
        product.description ??
        'Tidak ada deskripsi produk.';

    DiscountedProduct? discountedProduct;

    if (product is DiscountedProduct) {
      discountedProduct =
          product as DiscountedProduct;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // =========================
            // GAMBAR PRODUK
            // =========================
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 90,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // NAMA PRODUK
            // =========================
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // =========================
            // HARGA
            // =========================
            if (discountedProduct != null) ...[
              Text(
                'Rp ${discountedProduct.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration:
                      TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(height: 3),
              PriceLabel(
                price:
                    discountedProduct.finalPrice,
              ),
            ] else
              PriceLabel(
                price: product.price,
              ),

            const SizedBox(height: 12),

            // =========================
            // KATEGORI + STATUS STOK
            // =========================
            Row(
              children: [
                CategoryTag(
                  category: product.category,
                ),
                const SizedBox(width: 10),
                StockBadge(
                  status:
                      product.getStatusStok(),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =========================
            // DESKRIPSI
            // =========================
            const Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 12),

            // =========================
            // STOK
            // =========================
            Text(
              'Stok tersedia: ${product.stock}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 24),

            // =========================
            // JUMLAH
            // =========================
            const Text(
              'Jumlah',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: quantity > 1
                        ? () {
                            setState(() {
                              quantity--;
                            });
                          }
                        : null,
                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed:
                        quantity < product.stock
                            ? () {
                                setState(() {
                                  quantity++;
                                });
                              }
                            : null,
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =========================
            // TAMBAH KE KERANJANG
            // =========================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: product.stock > 0
                    ? () {
                        Navigator.pop(
                          context,
                          quantity,
                        );
                      }
                    : null,
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                label: const Text(
                  'Tambah ke Keranjang',
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}