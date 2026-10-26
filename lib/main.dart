
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/main_page.dart';
import 'screens/product_detail_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TokoKitaApp());
}

class TokoKitaApp extends StatelessWidget {
  const TokoKitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
      getPages: [
        GetPage(
          name: '/detail',
          page: () => const ProductDetailPage(),
        ),
      ],
    );
  }
}
