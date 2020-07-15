import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movie_db/model/movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=ac313fc1138a0ed697567a0dedddc6cd';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;

    //waits for a Future to complete. It won't go to next line of its thread until it completes this line
    http.Response result = await http.get(upcoming);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
