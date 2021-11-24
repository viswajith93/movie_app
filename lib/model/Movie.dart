class Movie {
  final int id;
  final bool adult;
  final String title;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;

  Movie({
    required this.id,
    required this.adult,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
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
        popularity: moviesJson['vote_average'],
        posterPath: moviesJson['poster_path'],
        releaseDate: moviesJson['release_date']);
  }
}
