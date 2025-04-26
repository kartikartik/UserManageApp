import 'package:user_manage_app/model/movie/movie_list_model.dart';

class MovieListState {
  final List<MovieListModel> movies;
  final bool hasReachedMax;
  final String? errorMessage;

  MovieListState({
    this.movies = const [],
    this.hasReachedMax = false,
    this.errorMessage,
  });
}
