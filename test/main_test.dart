import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:flutter/foundation.dart';

void main() {
  setUp(() {
    rootBundle.clear();
  });
  group('DropdownMenuItem widget tests', () {
    testWidgets('DropdownMenuItem displays the correct text and value',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownMenu<int>(
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 1, label: '1 Person')
              ],
              onSelected: (int? value) {},
            ),
          ),
        ),
      );

      expect(find.text('1 Person'), findsOneWidget);
    });
  });
  group('App smoke test', () {
    testWidgets('App displays HomeView as home', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();
      expect(find.byType(HomeView), findsOneWidget);
      expect(find.byIcon(Icons.shopping_basket), findsOneWidget);
    });

    testWidgets('Displays movie cards with names and prices',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();
      expect(find.text('Wildwood'), findsOneWidget);
      expect(find.text('£10.99'), findsWidgets);
      expect(
          find.text('Wake Up Dead Man: A Knives Out Mystery'), findsOneWidget);
      expect(find.text('Add to Order'), findsWidgets);

      await tester.scrollUntilVisible(
          find.text('Kubo and the Two Strings'), 150);
      expect(find.text('£8.99'), findsOneWidget);
    });

    testWidgets('Tapping Order navigates to Movie Page with selected movie',
        (WidgetTester tester) async {
      CartRepository.instance.clear();
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to Order').first);
      await tester.pumpAndSettle();

      expect(find.byType(BookingWidget), findsOneWidget);
      expect(find.text('Wildwood (PG13)'), findsOneWidget);
      expect(find.text('Select quantities (up to 5 people in total)'),
          findsOneWidget);
      expect(find.text('Add to Basket'), findsOneWidget);

      final quantityDropdown = find.byType(DropdownButton<int>);
      await tester.ensureVisible(quantityDropdown);
      await tester.pumpAndSettle();
      await tester.tap(quantityDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('3 People'));
      await tester.pumpAndSettle();

      final addButton = find.text('Add to Basket');
      await tester.ensureVisible(addButton);
      await tester.pumpAndSettle();
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('Added 3 Wildwood ticket(s) to basket'), findsOneWidget);
      final items = CartRepository.instance.getItems();
      expect(items, hasLength(1));
      expect(items.single.movie.title, 'Wildwood');
      expect(items.single.ticketQuantity, 3);
    });
  });

  test('Android is supported', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(isSupportedPlatform(), isTrue);
    debugDefaultTargetPlatformOverride = null;
  });

  test('Other platforms are not supported', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(isSupportedPlatform(), isFalse);
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    expect(isSupportedPlatform(), isFalse);
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    expect(isSupportedPlatform(), isFalse);
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    expect(isSupportedPlatform(), isFalse);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('The unsupported platform screen explains what to do',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnsupportedPlatformApp());
    expect(find.textContaining('Android emulator'), findsOneWidget);
  });
}
