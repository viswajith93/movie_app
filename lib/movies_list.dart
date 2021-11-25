import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_detail.dart';

import 'constant.dart';
import 'model/Movie.dart';

class MovieList extends StatelessWidget {
  Future<List<Movie>> getData() async {
    var data = await getMovies();
    var jsonMoviesList = data['results'];
    return List<Movie>.from(
      jsonMoviesList.map(
        (model) => Movie.fromJson(model),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        centerTitle: true,
        title: Text(
          'Movies',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          MovieTitle(),
          FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                var movies = snapshot.data ?? List.empty();
                return Expanded(
                  child: ListView.separated(
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
              return Center(
                child: Text(
                  'Sorry! Something went wrong',
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class MovieTitle extends StatelessWidget {
  const MovieTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Top Rated',
          style: TextStyle(
            fontSize: 30,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MovieCell extends StatelessWidget {
  final Movie movie;

  const MovieCell(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(children: [
            Container(
              width: 70.0,
              height: 70.0,
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'http://image.tmdb.org/t/p/w500/${movie.posterPath}',
                  ),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor,
                    blurRadius: 5.0,
                    offset: new Offset(2.0, 5.0),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        movie.title,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      movie.overview,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: secondaryColor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MovieDetail(movie);
          }));
        });
  }
}

Future<Map> getMovies() async {
  var movieKey = dotenv.env['MOVIE_KEY'];
  var url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$movieKey';
  http.Response response = await http.get(
    Uri.parse(url),
  );
  return json.decode(response.body);
}
