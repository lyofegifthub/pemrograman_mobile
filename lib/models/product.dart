class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  int stock;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
    this.description,
  });

  String getStatusStok() {
    if (stock == 0) {
      return 'Habis';
    } else if (stock <= 5) {
      return 'Stok Terbatas';
    } else {
      return 'Tersedia';
    }
  }

  void displayInfo() {
    print('----------------------------------------');
    print('ID          : $id');
    print('Nama        : $name');
    print('Harga       : Rp ${price.toStringAsFixed(0)}');
    print('Kategori    : $category');
    print('Stok        : $stock');
    print('Status      : ${getStatusStok()}');
    print('Gambar      : $imageUrl');
    print(
      'Deskripsi   : ${description ?? "Tidak ada deskripsi"}',
    );
    print('----------------------------------------');
  }
}

class DiscountedProduct extends Product {
  final double discountPercent;

  DiscountedProduct({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.category,
    required super.stock,
    super.description,
    required this.discountPercent,
  });

  double get finalPrice {
    return price - (price * discountPercent / 100);
  }

  @override
  void displayInfo() {
    print('----------------------------------------');
    print('ID          : $id');
    print('Nama        : $name');
    print('Harga Awal  : Rp ${price.toStringAsFixed(0)}');
    print('Diskon      : $discountPercent%');
    print(
      'Harga Final : Rp ${finalPrice.toStringAsFixed(0)}',
    );
    print('Kategori    : $category');
    print('Stok        : $stock');
    print('Status      : ${getStatusStok()}');
    print('Gambar      : $imageUrl');
    print(
      'Deskripsi   : ${description ?? "Tidak ada deskripsi"}',
    );
    print('----------------------------------------');
  }
}

final List<Product> dummyProducts = [
  Product(
    id: 'P001',
    name: 'Laptop ASUS',
    price: 8500000,
    imageUrl: 'https://example.com/laptop.jpg',
    category: 'Elektronik',
    stock: 10,
    description: 'Laptop untuk kebutuhan kuliah dan pekerjaan.',
  ),

  DiscountedProduct(
    id: 'P002',
    name: 'Smartphone Samsung',
    price: 5000000,
    imageUrl: 'https://example.com/smartphone.jpg',
    category: 'Elektronik',
    stock: 3,
    description: 'Smartphone Android dengan fitur lengkap.',
    discountPercent: 10,
  ),

  Product(
    id: 'P003',
    name: 'Mouse Wireless',
    price: 150000,
    imageUrl: 'https://example.com/mouse.jpg',
    category: 'Elektronik',
    stock: 20,
    description: 'Mouse wireless untuk komputer dan laptop.',
  ),

  DiscountedProduct(
    id: 'P004',
    name: 'Keyboard Mechanical',
    price: 450000,
    imageUrl: 'https://example.com/keyboard.jpg',
    category: 'Elektronik',
    stock: 4,
    description: 'Keyboard mechanical untuk mengetik dan gaming.',
    discountPercent: 15,
  ),

  Product(
    id: 'P005',
    name: 'Kaos Polos',
    price: 100000,
    imageUrl: 'https://example.com/kaos.jpg',
    category: 'Fashion',
    stock: 15,
    description: 'Kaos polos berbahan cotton.',
  ),

  Product(
    id: 'P006',
    name: 'Celana Jeans',
    price: 300000,
    imageUrl: 'https://example.com/jeans.jpg',
    category: 'Fashion',
    stock: 0,
    description: 'Celana jeans dengan model casual.',
  ),

  DiscountedProduct(
    id: 'P007',
    name: 'Roti Tawar',
    price: 20000,
    imageUrl: 'https://example.com/roti.jpg',
    category: 'Makanan',
    stock: 8,
    description: 'Roti tawar untuk sarapan.',
    discountPercent: 5,
  ),

  Product(
    id: 'P008',
    name: 'Kopi Arabica',
    price: 75000,
    imageUrl: 'https://example.com/kopi.jpg',
    category: 'Makanan',
    stock: 6,
    description: 'Kopi Arabica dengan aroma khas.',
  ),

  Product(
    id: 'P009',
    name: 'Headset Bluetooth',
    price: 350000,
    imageUrl: 'https://example.com/headset.jpg',
    category: 'Elektronik',
    stock: 12,
    description: 'Headset bluetooth untuk musik dan meeting.',
  ),

  DiscountedProduct(
    id: 'P010',
    name: 'Smartwatch',
    price: 1200000,
    imageUrl: 'https://example.com/smartwatch.jpg',
    category: 'Elektronik',
    stock: 7,
    description: 'Smartwatch dengan fitur kesehatan dan notifikasi.',
    discountPercent: 12,
  ),

  Product(
    id: 'P011',
    name: 'Hoodie',
    price: 250000,
    imageUrl: 'https://example.com/hoodie.jpg',
    category: 'Fashion',
    stock: 9,
    description: 'Hoodie nyaman untuk aktivitas sehari-hari.',
  ),

  Product(
    id: 'P012',
    name: 'Tas Ransel',
    price: 275000,
    imageUrl: 'https://example.com/tas.jpg',
    category: 'Fashion',
    stock: 5,
    description: 'Tas ransel untuk kuliah dan aktivitas harian.',
  ),

  DiscountedProduct(
    id: 'P013',
    name: 'Biskuit Cokelat',
    price: 30000,
    imageUrl: 'https://example.com/biskuit.jpg',
    category: 'Makanan',
    stock: 14,
    description: 'Biskuit cokelat untuk camilan.',
    discountPercent: 8,
  ),

  Product(
    id: 'P014',
    name: 'Teh Hijau',
    price: 45000,
    imageUrl: 'https://example.com/teh.jpg',
    category: 'Makanan',
    stock: 11,
    description: 'Teh hijau dengan rasa ringan.',
  ),

  Product(
    id: 'P015',
    name: 'Power Bank',
    price: 220000,
    imageUrl: 'https://example.com/powerbank.jpg',
    category: 'Elektronik',
    stock: 13,
    description: 'Power bank untuk mengisi daya perangkat.',
  ),
];

double hitungTotalBelanja(List<Product> keranjang) {
  double total = 0;

  for (Product product in keranjang) {
    total += product.price;
  }

  return total;
}