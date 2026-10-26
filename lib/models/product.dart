
class Product {
  final int id;
  final String name;
  final double price;
  final String? description;
  final String category;
  final String image;
  final int stock;

  final String marketplaceUrl;
  final String shopName;
  final double? rating;
  final String soldLabel;
  final String source;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.category = 'Lainnya',
    this.image = '',
    this.stock = 20,
    this.marketplaceUrl = '',
    this.shopName = '',
    this.rating,
    this.soldLabel = '',
    this.source = 'Tokopedia',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final rawPrice = json['price_value'] ??
        json['price'] ??
        json['price_numeric'] ??
        0;

    double parsedPrice = 0;

    if (rawPrice is num) {
      parsedPrice = rawPrice.toDouble();
    } else {
      // Mendukung angka maupun teks harga sederhana.
      final cleaned = rawPrice
          .toString()
          .replaceAll(RegExp(r'[^0-9.,]'), '')
          .replaceAll('.', '')
          .replaceAll(',', '.');

      parsedPrice = double.tryParse(cleaned) ?? 0;
    }

    final rawId = json['product_id'] ?? json['id'] ?? 0;
    final rawRating = json['rating'] ?? json['rating_value'];
    final rawShop = json['shop'];

    String parsedShop = '';

    if (rawShop is Map) {
      parsedShop =
          (rawShop['name'] ?? rawShop['shop_name'] ?? '').toString();
    } else if (rawShop is String) {
      parsedShop = rawShop;
    }

    final rawStock = json['stock'];

    return Product(
      id: int.tryParse(rawId.toString()) ?? 0,
      name: (json['name'] ??
              json['title'] ??
              json['product_name'] ??
              'Produk tanpa nama')
          .toString(),
      price: parsedPrice,
      description: (json['description'] ?? '').toString(),
      category: (json['category'] ?? 'Lainnya').toString(),
      image: (json['image_url'] ??
              json['image'] ??
              json['thumbnail'] ??
              '')
          .toString(),
      // Nilai 20 hanya cadangan tampilan, bukan stok terverifikasi.
      stock: rawStock is num ? rawStock.toInt() : 20,
      marketplaceUrl:
          (json['url'] ?? json['product_url'] ?? '').toString(),
      shopName: parsedShop,
      rating: rawRating == null
          ? null
          : double.tryParse(rawRating.toString()),
      soldLabel: (json['sold'] ?? json['sold_count'] ?? '').toString(),
      source: (json['source'] ?? 'Tokopedia').toString(),
    );
  }

  String getStatusStok() {
    if (stock <= 0) return 'Habis';
    if (stock <= 5) return 'Stok Menipis';
    return 'Tersedia';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'stock': stock,
      'marketplaceUrl': marketplaceUrl,
      'shopName': shopName,
      'rating': rating,
      'soldLabel': soldLabel,
      'source': source,
    };
  }
}

class DiscountedProduct extends Product {
  final double discount;

  const DiscountedProduct({
    required super.id,
    required super.name,
    required super.price,
    super.description,
    super.category,
    super.image,
    super.stock,
    super.marketplaceUrl,
    super.shopName,
    super.rating,
    super.soldLabel,
    super.source,
    required this.discount,
  });

  double get finalPrice => price * (1 - discount / 100);
}
