import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/Movie.dart';

import '../constant.dart';
import '../movie_section_enum.dart';
import 'movie_cell.dart';

class MoviesList extends StatelessWidget {
  final MovieSectionEnum movieSectionEnum;

  const MoviesList(this.movieSectionEnum);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getMovies(_getUrl(movieSectionEnum)),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text(
                  'Sorry! Something went wrong',
                );
              } else {
                var movies = snapshot.data ?? List.empty();
                return Container(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return MovieCell(
                        movies[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                );
              }
            }
        }
      },
    );
  }
}

Future<List<Movie>> _getMovies(String url) async {
  try {
    http.Response response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);
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

  switch (sectionEnum) {
    case MovieSectionEnum.now_playing:
      return '$nowPlayingUrl$movieKey';

    case MovieSectionEnum.top_rated:
      return '$topRatedUrl$movieKey';

    case MovieSectionEnum.popular:
      return '$popularUrl$movieKey';

    case MovieSectionEnum.upcoming:
      return '$upcomingUrl$movieKey';
  }
}
