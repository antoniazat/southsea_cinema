import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('creates Movie instance with given properties', () {
      const Movie movie = Movie(
        id: '1',
        title: 'Wildwood',
        synopsis:
            'After her baby brother is abducted by a murder of crows, headstrong teenager Prue McKeel launches a desperate rescue mission into an enchanted forest hidden just beyond Portland, Ore.',
        ageRating: 'PG13',
        duration: '2h 10m',
        pricing: 10.99,
        posterImagePath: '/assets/images/wildwood.jpg',
      );

      expect(movie.id, '1');
      expect(movie.title, 'Wildwood');
      expect(movie.synopsis,
          'After her baby brother is abducted by a murder of crows, headstrong teenager Prue McKeel launches a desperate rescue mission into an enchanted forest hidden just beyond Portland, Ore.');
      expect(movie.ageRating, 'PG13');
      expect(movie.duration, '2h 10m');
      expect(movie.pricing, 10.99);
      expect(movie.posterImagePath, '/assets/images/wildwood.jpg');
    });

    test(
        'formattedPrice returns price prefixed with pound sign and two decimals',
        () {
      const Movie movie = Movie(
        id: '1',
        title: 'Wildwood',
        synopsis:
            'After her baby brother is abducted by a murder of crows, headstrong teenager Prue McKeel launches a desperate rescue mission into an enchanted forest hidden just beyond Portland, Ore.',
        ageRating: 'PG13',
        duration: '2h 10m',
        pricing: 10.99,
        posterImagePath: '/assets/images/wildwood.jpg',
      );

      expect(movie.formattedPrice, '£10.99');
    });

    test('JSON conversion preserves every movie field', () {
      final Map<String, dynamic> data = <String, dynamic>{
        'id': '3',
        'title': 'Kubo and the Two Strings',
        'synopsis': 'Banishing an evil spirit with courage.',
        'ageRating': 'PG13',
        'duration': '1h 42m',
        'pricing': 7.99,
        'posterImagePath': '/assets/images/wildwood.jpg',
      };
      final Movie movie = Movie.fromJSON(data);
      expect(movie.id, '3');
      expect(movie.title, 'Kubo and the Two Strings');
      expect(movie.synopsis, 'Banishing an evil spirit with courage.');
      expect(movie.ageRating, 'PG13');
      expect(movie.duration, '1h 42m');
      expect(movie.pricing, 7.99);
      expect(movie.posterImagePath, '/assets/images/wildwood.jpg');
    });

    test('fromJson accepts a whole-number price', () {
      final Map<String, dynamic> data = <String, dynamic>{
        'id': '4',
        'title': 'ParaNorman',
        'synopsis': 'Something about a kid idk',
        'ageRating': 'PG13',
        'duration': '1h 50m',
        'pricing': 8,
        'posterImagePath': '/assets/images/wildwood.jpg',
      };
      final Movie movie = Movie.fromJSON(data);
      expect(movie.pricing, 8.0);
      expect(movie.pricing, isA<double>());
    });
  });
}
