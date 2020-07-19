import 'dart:async';

import 'package:movie_db/api/http_helper.dart';
import 'package:movie_db/bloc/bloc.dart';

class MoviesQueryBloc implements Bloc {
  final _controller = StreamController();
  final _helper = HttpHelper();

  Stream get movieStream => _controller.stream;

  void submitQuery(String query) async {
    final results = await _helper.findMovies(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
