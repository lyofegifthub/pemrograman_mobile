
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import 'main_page.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  String formatRupiah(num angka) {
    final value = angka.toInt().toString();
    final formatted = value.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
    return 'Rp$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 72,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  const Text('Tidak ada pesanan untuk ditampilkan.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => const MainPage());
                    },
                    child: const Text('Kembali ke Beranda'),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Ringkasan Pesanan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...controller.items.map((item) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag_outlined),
                        title: Text(item.product.name),
                        subtitle: Text(
                          '${item.quantity.value} x '
                          '${formatRupiah(item.hargaSatuan)}',
                        ),
                        trailing: Text(
                          formatRupiah(item.subtotal),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        formatRupiah(controller.totalHarga),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Konfirmasi Pesanan'),
                          content: const Text(
                            'Pesanan akan diselesaikan sebagai '
                            'simulasi checkout. Lanjutkan?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.clearCart();

                                // Tutup dialog terlebih dahulu.
                                Get.back();

                                // Kembali ke halaman utama tanpa
                                // menyisakan halaman checkout.
                                Get.offAll(
                                  () => const MainPage(),
                                );

                                Get.snackbar(
                                  'Pesanan berhasil',
                                  'Checkout simulasi selesai.',
                                );
                              },
                              child: const Text('Konfirmasi'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Konfirmasi Pesanan'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
