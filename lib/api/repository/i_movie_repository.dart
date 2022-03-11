import 'package:movie_app/model/Movie.dart';

import '../../common/movie_section_enum.dart';

abstract class IMovieRepository {
  Future<List<Movie>> getMovies(MovieSectionEnum movieSectionEnum, int page);
}
