class Movie {
  final int? id;
  final bool? adult;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final double averageVote;
  final String? posterPath;
  final String? releaseDate;

  Movie({
    required this.id,
    required this.adult,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.averageVote,
    required this.posterPath,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<dynamic, dynamic> moviesJson) {
    return Movie(
        id: moviesJson['id'],
        adult: moviesJson['adult'],
        title: moviesJson['title'],
        originalTitle: moviesJson['original_title'],
        overview: moviesJson['overview'],
        averageVote: moviesJson['vote_average'].toDouble(),
        posterPath: moviesJson['poster_path'],
        releaseDate: moviesJson['release_date']);
  }
}
