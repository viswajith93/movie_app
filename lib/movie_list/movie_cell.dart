import 'package:flutter/material.dart';

import '../constant.dart';
import '../model/Movie.dart';
import '../movie_detail.dart';

class MovieCell extends StatelessWidget {
  final Movie movie;

  const MovieCell(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: 200.0,
            height: 150.0,
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                  '$imageBaseUrl${movie.posterPath}',
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
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MovieDetail(movie);
          }));
        });
  }
}
