
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';

// Menyimpan satu produk beserta jumlahnya di keranjang.
class CartItem {
  final Product product;
  final RxInt quantity;

  CartItem({
    required this.product,
    int quantity = 1,
  }) : quantity = quantity.obs;

  // Mendukung harga normal dan harga setelah diskon.
  double get hargaSatuan {
    if (product is DiscountedProduct) {
      return (product as DiscountedProduct).finalPrice.toDouble();
    }

    return product.price.toDouble();
  }

  // Subtotal harga produk sesuai jumlah yang dipilih.
  double get subtotal => hargaSatuan * quantity.value;
}

class CartController extends GetxController {
  // Daftar produk yang tersimpan di keranjang.
  final RxList<CartItem> items = <CartItem>[].obs;

  // Menghitung jumlah seluruh produk.
  int get totalItem {
    return items.fold(
      0,
      (total, item) => total + item.quantity.value,
    );
  }

  // Menghitung seluruh subtotal produk.
  double get totalHarga {
    return items.fold(
      0.0,
      (total, item) => total + item.subtotal,
    );
  }

  // Menambahkan produk ke keranjang.
  void addToCart(Product product, {int quantity = 1}) {
    if (product.stock <= 0 || quantity <= 0) {
      Get.snackbar(
        'Stok tidak tersedia',
        'Produk ini tidak bisa ditambahkan.',
      );
      return;
    }

    final index = items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      final item = items[index];
      final jumlahBaru = item.quantity.value + quantity;

      if (jumlahBaru > product.stock) {
        item.quantity.value = product.stock;
        Get.snackbar(
          'Batas stok',
          'Jumlah disesuaikan dengan stok yang tersedia.',
        );
      } else {
        item.quantity.value = jumlahBaru;
      }

      items.refresh();
    } else {
      final jumlahAwal =
          quantity > product.stock ? product.stock : quantity;

      items.add(
        CartItem(
          product: product,
          quantity: jumlahAwal,
        ),
      );
    }

    Get.snackbar(
      'Keranjang',
      '${product.name} ditambahkan ke keranjang.',
    );
  }

  // Menambah quantity satu produk.
  void increaseQuantity(CartItem item) {
    if (item.quantity.value < item.product.stock) {
      item.quantity.value++;
      items.refresh();
    } else {
      Get.snackbar(
        'Stok maksimal',
        'Jumlah tidak bisa melebihi stok produk.',
      );
    }
  }

  // Mengurangi quantity satu produk.
  void decreaseQuantity(CartItem item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
      items.refresh();
    } else {
      removeFromCart(item.product);
    }
  }

  // Menghapus satu produk.
  void removeFromCart(Product product) {
    items.removeWhere(
      (item) => item.product.id == product.id,
    );
  }

  // Memunculkan konfirmasi sebelum keranjang dikosongkan.
  void confirmClearCart() {
    if (items.isEmpty) {
      Get.snackbar(
        'Keranjang kosong',
        'Tidak ada produk yang perlu dihapus.',
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        title: const Text('Kosongkan Keranjang?'),
        content: const Text(
          'Semua produk di keranjang akan dihapus. '
          'Apakah kamu yakin ingin melanjutkan?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              clearCart();
              Get.back();

              Get.snackbar(
                'Berhasil',
                'Semua produk telah dihapus dari keranjang.',
              );
            },
            child: const Text('Ya, Kosongkan'),
          ),
        ],
      ),
    );
  }

  // Menghapus seluruh produk dari keranjang.
  void clearCart() {
    items.clear();
  }
}
