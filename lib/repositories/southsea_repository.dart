import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class SouthseaRepository {
  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }
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

  Movie? getMovieById(String id) {
    for (final Movie movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }

  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<Movie> loadedMovies = [];

    for (final dynamic item in jsonList) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      final Movie movie = Movie.fromJSON(itemMap);
      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }
}
