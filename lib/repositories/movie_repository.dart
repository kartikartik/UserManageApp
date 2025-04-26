import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_manage_app/model/movie_detail_model.dart';
import 'package:user_manage_app/model/movie_list_model.dart';
import 'package:user_manage_app/utils/constants.dart';

class MovieRepository {

Future<List<MovieListModel>> fetchMovies(int page) async {
  final response = await http.get(
    Uri.parse('$movieListUrl$page&api_key=$movieToken'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data == null) {
      throw Exception('No data returned from API');
    }
    return (data['results'] as List)
        .map((movie) => MovieListModel.fromJson(movie))
        .toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

Future<MovieDetailModel> fetchMovieDetail(int movieId) async {
  final response = await http.get(
    Uri.parse('$movieDetailsUrl$movieId?api_key=$movieToken'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data == null) {
      throw Exception('No data returned from API');
    }
    return MovieDetailModel.fromJson(data);
  } else {
    throw Exception('Failed to load movie details');
  }
}


}
