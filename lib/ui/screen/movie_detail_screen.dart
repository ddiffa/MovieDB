import 'package:flutter/material.dart';
import 'package:movie_db/constant/constant.dart';
import 'package:movie_db/model/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie _movie;

  MovieDetailScreen(this._movie);

  @override
  Widget build(BuildContext context) {
    String path;
    if (_movie.posterPath != null) {
      path = Constant.imagePath + _movie.posterPath;
    } else {
      path = Constant.defaultImage;
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
              Text(
                'Overview',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(_movie.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}
