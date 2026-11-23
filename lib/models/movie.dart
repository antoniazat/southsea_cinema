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

  String get formattedPrice => '£${pricing.toStringAsFixed(2)}';

  factory Movie.fromJSON(Map<String, dynamic> json) {
    final String id = json['id'] as String;
    final String title = json['title'] as String;
    final String synopsis = json['synopsis'] as String;
    final String duration = json['duration'] as String;
    final String ageRating = json['ageRating'] as String;
    final num priceNumber = json['pricing'] as num;
    final double pricing = priceNumber.toDouble();
    final String posterImagePath = json['posterImagePath'] as String;

    return Movie(
      id: id,
      title: title,
      synopsis: synopsis,
      duration: duration,
      pricing: pricing,
      ageRating: ageRating,
      posterImagePath: posterImagePath,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'title': title,
      'synopsis': synopsis,
      'duration': duration,
      'ageRating': ageRating,
      'pricing': pricing,
      'posterImagePath': posterImagePath,
    };
    return data;
  }
}
