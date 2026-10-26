import 'package:flutter/material.dart';

import '../models/product.dart';
import 'price_label.dart';
import 'stock_badge.dart';
import 'category_tag.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    DiscountedProduct? discountedProduct;

    if (widget.product is DiscountedProduct) {
      discountedProduct =
          widget.product as DiscountedProduct;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // GAMBAR PRODUK
            // =========================
            SizedBox(
              width: 120,
              height: 135,
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 135,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),

                  // Badge diskon
                  if (discountedProduct != null)
                    Positioned(
                      top: 7,
                      left: 7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Diskon',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),

                  // Badge stok
                  Positioned(
                    left: 6,
                    bottom: 6,
                    child: StockBadge(
                      status:
                          widget.product.getStatusStok(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // =========================
            // INFORMASI PRODUK
            // =========================
            Expanded(
              child: SizedBox(
                height: 135,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // Nama + Favorite
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            maxLines: 2,
                            overflow:
                                TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 21,
                            color: isFavorite
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    // Kategori
                    CategoryTag(
                      category: widget.product.category,
                    ),

                    const Spacer(),

                    // Harga
                    if (discountedProduct != null) ...[
                      Text(
                        'Rp ${discountedProduct.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration:
                              TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(height: 2),
                      PriceLabel(
                        price:
                            discountedProduct.finalPrice,
                      ),
                    ] else
                      PriceLabel(
                        price: widget.product.price,
                      ),

                    const SizedBox(height: 5),

                    // Stok
                    Text(
                      'Stok: ${widget.product.stock}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}