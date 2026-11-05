import 'package:southsea_cinema/models/movie.dart';

class SouthseaRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: '1',
        title: 'Wildwood',
        synopsis:
            'After her baby brother is abducted by a murder of crows, headstrong teenager Prue McKeel launches a desperate rescue mission into an enchanted forest hidden just beyond Portland, Ore.',
        ageRating: 'PG13',
        duration: '2h 10m',
        pricing: 10.99,
        posterImagePath: 'assets/images/wildwood.jpg',
      ),
      Movie(
        id: '2',
        title: 'Wake Up Dead Man: A Knives Out Mystery',
        synopsis:
            'Detective Benoit Blanc heads to church to solve a perfectly impossible murder with help from a young priest.',
        ageRating: 'PG13',
        duration: '2h 26m',
        pricing: 10.99,
        posterImagePath:
            'assets/images/wake-up-dead-man-a-knives-out-mystery.jpg',
      ),
    ];
  }
}
