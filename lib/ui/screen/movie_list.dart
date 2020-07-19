import 'package:flutter/material.dart';
import 'package:movie_db/bloc/movie_bloc.dart';
import 'package:movie_db/ui/screen/search_screen.dart';
import 'package:movie_db/ui/widget/widget_movie_list.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MoviesBloc _bloc;

  @override
  void initState() {
    _bloc = MoviesBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: StreamBuilder(
            stream: _bloc.movies,
            initialData: _bloc.movieList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return buildList(snapshot.data);
            },
          ),
        ),
      ),
    );
  }
}
