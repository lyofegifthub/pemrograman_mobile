
import 'dart:convert';

import '../models/product.dart';

class ProductService {
  // Data produk dummy dalam format JSON.
  // Harga menggunakan rupiah dan gambar menggunakan foto langsung.
  static const String _productsJson = r'''
  [
    {
      "id": 1,
      "title": "Samsung Galaxy A55 5G",
      "price": 5499000,
      "description": "Smartphone 5G dengan layar Super AMOLED, kamera berkualitas, dan baterai tahan lama.",
      "category": "smartphone",
      "image": "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=700&q=80",
      "rating": 4.8,
      "sold": 1250,
      "stock": 25,
      "shop": {"name": "Digital Store"}
    },
    {
      "id": 2,
      "title": "iPhone 13 128GB",
      "price": 6999000,
      "description": "Smartphone dengan kamera ganda, performa cepat, dan desain premium.",
      "category": "smartphone",
      "image": "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?auto=format&fit=crop&w=700&q=80",
      "rating": 4.9,
      "sold": 980,
      "stock": 12,
      "shop": {"name": "Apple Corner"}
    },
    {
      "id": 3,
      "title": "Laptop ASUS VivoBook",
      "price": 7499000,
      "description": "Laptop untuk kuliah, pekerjaan kantor, multitasking, dan kebutuhan sehari-hari.",
      "category": "laptop",
      "image": "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=700&q=80",
      "rating": 4.7,
      "sold": 450,
      "stock": 15,
      "shop": {"name": "Laptop Center"}
    },
    {
      "id": 4,
      "title": "MacBook Air",
      "price": 13999000,
      "description": "Laptop tipis dan ringan untuk produktivitas, desain, dan kebutuhan belajar.",
      "category": "laptop",
      "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=700&q=80",
      "rating": 4.9,
      "sold": 320,
      "stock": 8,
      "shop": {"name": "Premium Gadget"}
    },
    {
      "id": 5,
      "title": "Headphone Wireless",
      "price": 349000,
      "description": "Headphone nirkabel dengan desain nyaman untuk mendengarkan musik dan belajar.",
      "category": "headphone",
      "image": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=700&q=80",
      "rating": 4.6,
      "sold": 2100,
      "stock": 40,
      "shop": {"name": "Audio Hub"}
    },
    {
      "id": 6,
      "title": "Smartwatch Sport",
      "price": 599000,
      "description": "Jam tangan pintar untuk memantau aktivitas harian dan olahraga.",
      "category": "elektronik",
      "image": "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=700&q=80",
      "rating": 4.5,
      "sold": 760,
      "stock": 30,
      "shop": {"name": "Tech Station"}
    },
    {
      "id": 7,
      "title": "Sepatu Sneakers Casual",
      "price": 399000,
      "description": "Sepatu kasual dengan desain modern untuk aktivitas harian.",
      "category": "sepatu",
      "image": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=700&q=80",
      "rating": 4.7,
      "sold": 1650,
      "stock": 35,
      "shop": {"name": "Urban Shoes"}
    },
    {
      "id": 8,
      "title": "Tas Selempang Casual",
      "price": 179000,
      "description": "Tas selempang simpel untuk membawa barang penting saat bepergian.",
      "category": "tas",
      "image": "https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=700&q=80",
      "rating": 4.5,
      "sold": 840,
      "stock": 28,
      "shop": {"name": "Everyday Bag"}
    },
    {
      "id": 9,
      "title": "Kaos Polos Premium",
      "price": 89000,
      "description": "Kaos berbahan nyaman dengan model sederhana untuk pemakaian sehari-hari.",
      "category": "fashion",
      "image": "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=700&q=80",
      "rating": 4.6,
      "sold": 2300,
      "stock": 60,
      "shop": {"name": "Basic Outfit"}
    },
    {
      "id": 10,
      "title": "Kamera Digital",
      "price": 4299000,
      "description": "Kamera digital untuk dokumentasi perjalanan, kegiatan, dan fotografi sehari-hari.",
      "category": "elektronik",
      "image": "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=700&q=80",
      "rating": 4.8,
      "sold": 190,
      "stock": 7,
      "shop": {"name": "Camera House"}
    },
    {
      "id": 11,
      "title": "Keyboard Mechanical",
      "price": 459000,
      "description": "Keyboard untuk mengetik dan bermain game dengan pengalaman mengetik yang nyaman.",
      "category": "aksesoris",
      "image": "https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=700&q=80",
      "rating": 4.7,
      "sold": 570,
      "stock": 20,
      "shop": {"name": "Gamer Zone"}
    },
    {
      "id": 12,
      "title": "Buku Catatan Premium",
      "price": 35000,
      "description": "Buku catatan untuk menulis materi kuliah, membuat rencana, dan mencatat ide.",
      "category": "alat tulis",
      "image": "https://images.unsplash.com/photo-1531346878377-a5be20888e57?auto=format&fit=crop&w=700&q=80",
      "rating": 4.5,
      "sold": 680,
      "stock": 75,
      "shop": {"name": "Stationery Mart"}
    },
    {
      "id": 13,
      "title": "Burger Beef",
      "price": 28000,
      "description": "Burger dengan patty daging sapi, sayuran segar, dan roti lembut.",
      "category": "makanan dan minuman",
      "image": "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=700&q=80",
      "rating": 4.7,
      "sold": 940,
      "stock": 40,
      "shop": {"name": "Burger Corner"}
    },
    {
      "id": 14,
      "title": "Salad Buah Segar",
      "price": 22000,
      "description": "Potongan buah segar dengan saus salad yang cocok untuk camilan.",
      "category": "makanan dan minuman",
      "image": "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=700&q=80",
      "rating": 4.6,
      "sold": 520,
      "stock": 32,
      "shop": {"name": "Fresh Food"}
    }
  ]
  ''';

  List<Product>? _cachedProducts;

  Future<List<Product>> _loadProducts() async {
    if (_cachedProducts != null) {
      return _cachedProducts!;
    }

    final List<dynamic> decoded = jsonDecode(_productsJson);

    _cachedProducts = decoded
        .map((item) => Product.fromJson(
              Map<String, dynamic>.from(item as Map),
            ))
        .toList();

    return _cachedProducts!;
  }

  // Mengambil produk, pencarian, dan pagination dari JSON lokal.
  Future<List<Product>> fetchProducts({
    String query = 'produk populer',
    int page = 1,
  }) async {
    final products = await _loadProducts();
    final normalizedQuery = query.trim().toLowerCase();

    final filteredProducts = normalizedQuery.isEmpty ||
            normalizedQuery == 'produk populer'
        ? products
        : products.where((product) {
            final name = product.name.toLowerCase();
            final category = product.category.toLowerCase();
            final description =
                (product.description ?? '').toLowerCase();

            return name.contains(normalizedQuery) ||
                category.contains(normalizedQuery) ||
                description.contains(normalizedQuery);
          }).toList();

    const pageSize = 20;
    final startIndex = (page - 1) * pageSize;

    if (startIndex < 0 || startIndex >= filteredProducts.length) {
      return [];
    }

    final endIndex =
        (startIndex + pageSize).clamp(0, filteredProducts.length);

    return filteredProducts.sublist(startIndex, endIndex);
  }

  // Mengambil detail produk berdasarkan ID.
  Future<Product?> fetchProductDetail(int id) async {
    final products = await _loadProducts();

    for (final product in products) {
      if (product.id == id) {
        return product;
      }
    }

    return null;
  }

  // Simulasi penambahan produk tanpa server/API.
  Future<Product> createProduct({
    required String name,
    required double price,
    required String description,
    required String category,
    required String image,
  }) async {
    final products = await _loadProducts();

    final newId = products.isEmpty
        ? 1
        : products
                .map((product) => product.id)
                .reduce((a, b) => a > b ? a : b) +
            1;

    final jsonProduct = <String, dynamic>{
      'id': newId,
      'title': name,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': 0.0,
      'sold': 0,
      'stock': 20,
      'shop': {'name': 'TokoKita'},
    };

    final newProduct = Product.fromJson(jsonProduct);
    products.add(newProduct);

    return newProduct;
  }

  void dispose() {
    // Tidak ada koneksi HTTP yang perlu ditutup.
  }
}
