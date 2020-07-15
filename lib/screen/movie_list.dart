import 'package:flutter/material.dart';
import 'package:movie_db/screen/movie_detail_screen.dart';

import '../api/http_helper.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int _moviesCount;
  List _movies;
  HttpHelper _helper;

  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Movies');

  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  @override
  void initState() {
    _helper = HttpHelper();
    initialize();
    super.initState();
  }

  void initialize() async {
    _movies = List();
    _movies = await _helper.getUpcoming();
    setState(() {
      _moviesCount = _movies.length;
      _movies = _movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
            icon: this.visibleIcon,
            onPressed: () {
              setState(() {
                if (this.visibleIcon.icon == Icons.search) {
                  this.visibleIcon = Icon(Icons.cancel);
                  this.searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (String text) {
                      search(text);
                    },
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  );
                } else {
                  setState(() {
                    this.visibleIcon = Icon(Icons.search);
                    this.searchBar = Text('Movies');
                  });
                }
              });
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int position) {
          if (_movies[position].posterPath != null) {
            image = NetworkImage(iconBase + _movies[position].posterPath);
          } else {
            image = NetworkImage(defaultImage);
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => MovieDetailScreen(_movies[position]));
                Navigator.push(context, route);
              },
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(_movies[position].title),
              subtitle: Text(
                  'Released : ${_movies[position].releaseDate} \nVote : ${_movies[position].voteAverage.toString()}'),
            ),
          );
        },
        itemCount: (this._moviesCount == null) ? 0 : this._moviesCount,
      ),
    );
  }

  Future search(text) async {
    _movies = await _helper.findMovies(text);
    setState(() {
      _moviesCount = _movies.length;
      _movies = _movies;
    });
  }
}
