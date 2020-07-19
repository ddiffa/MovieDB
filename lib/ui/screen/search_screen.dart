import 'package:flutter/material.dart';
import 'package:movie_db/bloc/bloc_provider.dart';
import 'package:movie_db/bloc/movie_query_bloc.dart';
import 'package:movie_db/ui/widget/widget_movie_list.dart';

class SearchScreen extends StatelessWidget {
  final bloc = MoviesQueryBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: bloc,
        child: Scaffold(
          appBar: AppBar(
            title: Text('what movie you want to find?'),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a movie title'),
                  onChanged: (query) => bloc.submitQuery(query),
                ),
              ),
              Expanded(child: _buildResults(bloc))
            ],
          ),
        ));
  }

  Widget _buildResults(MoviesQueryBloc bloc) {
    return StreamBuilder(
      stream: bloc.movieStream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(
            child: Text('Enter a movie title'),
          );
        }
        if (results.isEmpty) {
          return Center(
            child: Text('No Results'),
          );
        }
        return buildList(results);
      },
    );
  }
}
