import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/api/viewmodel/movie_viewmodel.dart';
import 'package:movie_app/common/api_response.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/retry.dart';
import 'package:provider/provider.dart';

import '../common/movie_section_enum.dart';
import 'movie_cell.dart';

class MoviesList extends StatefulWidget {
  final MovieSectionEnum _movieSectionEnum;

  MoviesList(this._movieSectionEnum);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  final ScrollController _scrollController = new ScrollController();
  final MovieViewModel _movieViewModel = new MovieViewModel();

  int _page = 1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print('initState() called');
    _movieViewModel.getMovies(widget._movieSectionEnum, _page);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void didUpdateWidget(MoviesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget() called');
    _page = 1;
    _isLoading = false;
    _movieViewModel.clear();
    _movieViewModel.getMovies(widget._movieSectionEnum, _page);
  }

  void _scrollListener() {
    if (!_isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _page++;
      setState(() => _isLoading = true);
      _movieViewModel.getMovies(widget._movieSectionEnum, _page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _movieViewModel,
      child: Consumer<MovieViewModel>(builder: (context, viewModel, _) {
        switch (viewModel.response.status) {
          case Status.LOADING:
            if (viewModel.movies.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return _getMoviesListView(viewModel.movies);
            }

          case Status.COMPLETED:
            {
              _isLoading = false;
              return _getMoviesListView(viewModel.movies);
            }

          case Status.ERROR:
            {
              _isLoading = false;
              if (viewModel.movies.isEmpty) {
                return Visibility(
                  child: RetryWidget(() {
                    _movieViewModel.getMovies(widget._movieSectionEnum, _page);
                  }),
                );
              } else {
                return _getMoviesListView(viewModel.movies);
              }
            }

          default:
            return Container();
        }
      }),
    );
  }

  Widget _getMoviesListView(List<Movie> movies) {
    return Container(
      height: 200.0,
      margin: EdgeInsets.only(left: 8.0),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: movies.length + 1,
        itemBuilder: (context, index) {
          if (index < movies.length) {
            return MovieCell(
              movies[index],
            );
          } else {
            return _getLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _getLoadingWidget() {
    return Visibility(
      visible: _isLoading,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
