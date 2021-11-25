import 'package:flutter/material.dart';
import 'package:movie_app/movie_section_enum.dart';

import '../constant.dart';
import 'movie_section_title.dart';
import 'movies_list.dart';

class MovieListHome extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieSectionTitle('Now playing'),
            MoviesList(MovieSectionEnum.now_playing),
            MovieSectionTitle('Top rated'),
            MoviesList(MovieSectionEnum.top_rated),
            MovieSectionTitle('Popular'),
            MoviesList(MovieSectionEnum.popular),
            MovieSectionTitle('Upcoming'),
            MoviesList(MovieSectionEnum.upcoming)
          ],
        ),
      ),
    );
  }
}
