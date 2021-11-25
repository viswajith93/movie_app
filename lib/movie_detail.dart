import 'dart:ui';

import 'package:flutter/material.dart';
import 'constant.dart';
import 'model/Movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageBaseUrl + movie.posterPath,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: 400.0,
                    height: 400.0,
                    alignment: Alignment.center,
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                        Text(
                          '${movie.averageVote}/10',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      movie.overview,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 150.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          child: Text(
                            'Rate Movie',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xaa3C3261),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xaa3C3261)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xaa3C3261)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
