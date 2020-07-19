import 'dart:async';

import 'bloc.dart';
import 'package:movie_db/api/http_helper.dart';

class MoviesBloc implements Bloc {
  HttpHelper _helper;
  List movieList;
  final _streamController = StreamController.broadcast();

  Stream get movies => _streamController.stream;

  MoviesBloc() {
    _helper = HttpHelper();
    getUpcomingMovies();
    _streamController.stream.listen(returnMovies);
  }

  void getUpcomingMovies() async {
    movieList = List();
    movieList = await _helper.getUpcoming();
    _streamController.add(movieList);
  }

  List returnMovies(movies) {
    return movies;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
