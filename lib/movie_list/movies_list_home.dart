import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/api/viewmodel/movie_viewmodel.dart';
import 'package:movie_app/common/movie_section_enum.dart';
import 'package:provider/provider.dart';

import '../common/constant.dart';
import 'movie_section_title.dart';
import 'movies_list.dart';

class MovieListHome extends StatefulWidget {
  @override
  State<MovieListHome> createState() => _MovieListHomeState();
}

class _MovieListHomeState extends State<MovieListHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        centerTitle: true,
        title: Text(
          _selectedIndex == 0 ? 'Movies' : 'TV shows',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: _selectedIndex == 0 ? _getMovieTabBody() : _getTVShowTabBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie,
            ),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
            ),
            label: 'TV shows',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onBottomBarItemTapped,
      ),
    );
  }

  void _onBottomBarItemTapped(int index) {
    dotenv.env['BASE_URL'] = (index == 0) ? movieBaseUrl : tvShowBaseUrl;
    if(index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _getMovieTabBody() {
    return SingleChildScrollView(
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
    );
  }

  Widget _getTVShowTabBody() {
    return SingleChildScrollView(
      child: Column(children: [
        MovieSectionTitle('Top rated'),
        MoviesList(MovieSectionEnum.top_rated),
        MovieSectionTitle('Popular'),
        MoviesList(MovieSectionEnum.popular),
      ]),
    );
  }
}
