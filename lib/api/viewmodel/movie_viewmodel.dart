import 'package:flutter/material.dart';
import 'package:movie_app/api/repository/i_movie_repository.dart';
import 'package:movie_app/api/repository/movie_repository.dart';
import 'package:movie_app/common/api_response.dart';
import 'package:movie_app/common/movie_section_enum.dart';
import 'package:movie_app/model/Movie.dart';

class MovieViewModel with ChangeNotifier {
  final IMovieRepository _movieRepository = MovieRepository();
  final List<Movie> _movies = [];

  ApiResponse _apiResponse = ApiResponse.initial();

  ApiResponse get response => _apiResponse;

  List<Movie> get movies => _movies;

  Future getMovies(MovieSectionEnum movieSectionEnum, int page) async {
    print('API hit');
    try {
      _apiResponse = ApiResponse.loading();
      List<Movie> movies =
          await _movieRepository.getMovies(movieSectionEnum, page);
      _movies.addAll(movies);
      _apiResponse = ApiResponse.completed(_movies);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void clear() {
    _movies.clear();
    _apiResponse = ApiResponse.initial();
  }
}
