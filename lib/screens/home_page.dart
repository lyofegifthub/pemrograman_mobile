
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductService _productService = ProductService();
  final TextEditingController _searchController =
      TextEditingController();

  late Future<List<Product>> _productsFuture;

  String _query = 'produk populer';

  final List<String> _quickSearches = const [
    'smartphone',
    'laptop',
    'sepatu',
    'tas',
    'headphone',
  ];

  @override
  void initState() {
    super.initState();
    _productsFuture = _productService.fetchProducts(
      query: _query,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchProducts([String? value]) {
    final newQuery = (value ?? _searchController.text).trim();

    if (newQuery.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nama produk terlebih dahulu.'),
        ),
      );
      return;
    }

    setState(() {
      _query = newQuery;
      _productsFuture = _productService.fetchProducts(
        query: _query,
      );
    });
  }

  Future<void> _refreshProducts() async {
    final future = _productService.fetchProducts(
      query: _query,
    );

    setState(() {
      _productsFuture = future;
    });

    try {
      await future;
    } catch (_) {
      // FutureBuilder menangani tampilan error.
    }
  }

  Widget _buildError(Object error) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Produk belum bisa dimuat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString().replaceFirst('Exception: ', ''),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: _refreshProducts,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    if (products.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 100),
          Icon(
            Icons.search_off,
            size: 56,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Center(
            child: Text('Produk tidak ditemukan.'),
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: products.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Text(
              '${products.length} produk ditemukan',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          );
        }

        return ProductCard(
          product: products[index - 1],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'TokoKita',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _refreshProducts,
            tooltip: 'Refresh produk',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Belanja lebih mudah',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Cari produk dari katalog marketplace.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: _searchProducts,
                  decoration: InputDecoration(
                    hintText: 'Cari HP, laptop, sepatu...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: _searchProducts,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF2F3F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _quickSearches.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _quickSearches[index];

                      return ActionChip(
                        label: Text(category),
                        onPressed: () {
                          _searchController.text = category;
                          _searchProducts(category);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 14),
                        Text('Mengambil data produk...'),
                      ],
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return _buildError(snapshot.error!);
                }

                return RefreshIndicator(
                  onRefresh: _refreshProducts,
                  child: _buildProductList(
                    snapshot.data ?? <Product>[],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
