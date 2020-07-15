import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movie_db/model/movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=ac313fc1138a0ed697567a0dedddc6cd';
  final String urlBase = 'https://api.themoviedb.org/3/';
  final String urlUpcoming = 'movie/upcoming?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase = 'search/movie?';

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

  Future<List> findMovies(String title) async {
    final String query = urlBase + urlSearchBase + urlKey + "&query=" + title;
    http.Response result = await http.get(query);
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
