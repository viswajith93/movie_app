import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/movie_list/movies_list_home.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Arvo',
      ),
      title: 'Flutter Movie app',
      home: MovieListHome(),
    );
  }
}
