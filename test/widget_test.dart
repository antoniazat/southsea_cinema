import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

void main() {
  group('DropdownMenuItem widget tests', () {
    testWidgets('DropdownMenuItem displays the correct text',
        (WidgetTester tester) async {
      const String testText = 'Test Item';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                  value: 'test',
                  child: Text(testText),
                ),
              ],
              onChanged: (String? value) {},
            ),
          ),
        ),
      );

      expect(find.text(testText), findsOneWidget);
    });
  });
}

