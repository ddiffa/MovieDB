import 'package:flutter/material.dart';
import 'package:movie_db/constant/constant.dart';
import 'package:movie_db/ui/screen/movie_detail_screen.dart';

Widget buildList(List results) {
  NetworkImage image;
  return ListView.builder(
    itemBuilder: (BuildContext context, int position) {
      if (results[position].posterPath != null) {
        image = NetworkImage(Constant.iconBase + results[position].posterPath);
      } else {
        image = NetworkImage(Constant.defaultImage);
      }
      return Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
                builder: (_) => MovieDetailScreen(results[position]));
            Navigator.push(context, route);
          },
          leading: CircleAvatar(
            backgroundImage: image,
          ),
          title: Text(results[position].title),
          subtitle: Text(
              'Released : ${results[position].releaseDate} \nVote : ${results[position].voteAverage.toString()}'),
        ),
      );
    },
    itemCount: (results.length == null) ? 0 : results.length,
  );
}
