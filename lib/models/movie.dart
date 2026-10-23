class Movie {
  final String id;
  final String title;
  final String synopsis;
  final String ageRating;
  final String duration;
  final double pricing;
  final String posterImagePath;

  const Movie({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.ageRating,
    required this.duration,
    required this.pricing,
    required this.posterImagePath,
  });
}
