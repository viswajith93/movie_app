import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/api/repository/DioHelper.dart';
import 'package:movie_app/api/repository/i_movie_repository.dart';
import 'package:movie_app/model/Movie.dart';

import '../../common/constant.dart';
import '../../common/movie_section_enum.dart';

class MovieRepository extends IMovieRepository {
  Dio _dio = DioHelper().getDioInstance();

  @override
  Future<List<Movie>> getMovies(
      MovieSectionEnum movieSectionEnum, int page) async {
    try {
      var url = _getUrl(movieSectionEnum);
      final response = await _dio.get(url + '&page=$page');
      Map<String, dynamic> data = response.data;
      var jsonMoviesList = data['results'];
      return List<Movie>.from(
        jsonMoviesList.map(
          (model) => Movie.fromJson(model),
        ),
      );
    } on Exception catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  String _getUrl(MovieSectionEnum sectionEnum) {
    var movieKey = dotenv.env['MOVIE_KEY'];
    var baseUrl = dotenv.env['BASE_URL'];
    switch (sectionEnum) {
      case MovieSectionEnum.now_playing:
        return '$baseUrl/$nowPlayingUrl$movieKey';

      case MovieSectionEnum.top_rated:
        return '$baseUrl/$topRatedUrl$movieKey';

      case MovieSectionEnum.popular:
        return '$baseUrl/$popularUrl$movieKey';

      case MovieSectionEnum.upcoming:
        return '$baseUrl/$upcomingUrl$movieKey';
    }
  }
}
