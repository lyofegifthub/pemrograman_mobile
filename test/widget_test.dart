import 'package:flutter_test/flutter_test.dart';
import 'package:tokokita/main.dart';

void main() {
  testWidgets('TokoKita menampilkan halaman utama', (WidgetTester tester) async {
    await tester.pumpWidget(const TokoKitaApp());

    expect(find.text('TokoKita'), findsWidgets);
    expect(find.text('Daftar Produk'), findsOneWidget);
  });
}