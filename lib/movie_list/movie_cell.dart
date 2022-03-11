import 'package:flutter/material.dart';

import '../common/constant.dart';
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
            width: 120.0,
            height: 10.0,
            margin: EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: NetworkImage(
                  '$imageBaseUrl${movie.posterPath}',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
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
