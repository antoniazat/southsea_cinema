import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/southsea_repository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SouthseaRepository repository = SouthseaRepository();
    final List<Movie> movies = repository.getMovies();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Listings'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieCard(movie: movies[index]);
        },
      ),
    );
  }
}
