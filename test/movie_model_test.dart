import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('creates Movie instance with given properties', () {
      const movie = Movie(
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
      const movie = Movie(
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
  });
}
