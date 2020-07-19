import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_db/model/movie.dart';

class HttpHelper {
  final String _urlKey = 'api_key=ac313fc1138a0ed697567a0dedddc6cd';
  final String _urlBase = 'https://api.themoviedb.org/3/';
  final String _urlUpcoming = 'movie/upcoming?';
  final String _urlLanguage = '&language=en-US';
  final String _urlSearchBase = 'search/movie?';

  Future getUpcoming() async {
    final String upcoming = _urlBase + _urlUpcoming + _urlKey + _urlLanguage;

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

  Future findMovies(String title) async {
    final String query = _urlBase + _urlSearchBase + _urlKey + "&query=" + title;
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
