import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/southsea_repository.dart';

void main() {
  group('SouthseaRepository unit tests', () {
    test('getMovies returns two movies', () {
      final SouthseaRepository repository = SouthseaRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovies contains valid Wildwood and Wake Up Dead Man movies', () {
      final SouthseaRepository repository = SouthseaRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie wildwood = movies[0];
      expect(wildwood.id, '1');
      expect(wildwood.title, 'Wildwood');
      expect(wildwood.pricing, 10.99);
      expect(wildwood.posterImagePath, isNotEmpty);

      final Movie wakeUpDeadManAKnivesOutMystery = movies[1];
      expect(wakeUpDeadManAKnivesOutMystery.id, '2');
      expect(wakeUpDeadManAKnivesOutMystery.title,
          'Wake Up Dead Man: A Knives Out Mystery');
      expect(wakeUpDeadManAKnivesOutMystery.pricing, 10.99);
      expect(wakeUpDeadManAKnivesOutMystery.posterImagePath, isNotEmpty);
    });
    test('getMovieById returns matching movie when id exists', () {
      final SouthseaRepository repository = SouthseaRepository();
      final Movie? movie = repository.getMovieById('1');

      expect(movie, isNotNull);
      expect(movie?.title, 'Wildwood');
      expect(movie?.pricing, 10.99);
    });

    test('getMovieById returns null when id does not exist', () {
      final SouthseaRepository repository = SouthseaRepository();
      final Movie? movie = repository.getMovieById('non-existent');

      expect(movie, isNull);
    });
  });
}
