import 'package:flutter/material.dart';
import 'package:movie_db/model/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie _movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  MovieDetailScreen(this._movie);

  @override
  Widget build(BuildContext context) {
    String path;
    if (_movie.posterPath != null) {
      path = imgPath + _movie.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(_movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                height: height / 1.5,
                child: Image.network(path),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(_movie.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}
