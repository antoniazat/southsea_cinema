import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

void main() {
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
      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text('Southsea Cinema & Arts Centre'), findsOneWidget);
    });

    testWidgets('Displays sandwich cards with names and prices',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      expect(find.text('Wildwood'), findsOneWidget);
      expect(find.text('£10.99'), findsNWidgets(2));
      expect(
          find.text('Wake Up Dead Man: A Knives Out Mystery'), findsOneWidget);
      expect(find.text('Select'), findsNWidgets(2));
    });

    testWidgets('Tapping Order navigates to OrderScreen with selected sandwich',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.text('Select').first);
      await tester.pumpAndSettle();

      expect(find.byType(BookingWidget), findsOneWidget);
      expect(find.text('Wildwood (PG13)'), findsOneWidget);
      expect(find.text('Select quantities (up to 5 people in total)'),
          findsOneWidget);
      expect(find.text('Add to Order'), findsOneWidget);

      final addButton = find.text('Add to Order');
      await tester.ensureVisible(addButton);
      await tester.pumpAndSettle();
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('Added 1 tickets to the order'), findsOneWidget);

      // await tester.tap(find.text('Remove'));
      // await tester.pump();
      // expect(find.text('0 Footlong Sub sandwich(es): '), findsOneWidget);
    });
  });
}
