import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/movie/movieList/movie_list_event.dart';
import 'package:user_manage_app/bloc/movie/movieList/movie_list_state.dart';
import 'package:user_manage_app/services/user_list_repository.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
     final MovieRepository movieRepository;

  MovieListBloc(this.movieRepository) : super(MovieListState()) {
    on<FetchMovies>((event, emit) async {
      // Fetch movies when the event is triggered
      try {
        final movies = await movieRepository.fetchMovies(event.page);
        emit(
          MovieListState(
            movies: List.from(state.movies)..addAll(movies),
            hasReachedMax: movies.isEmpty,
          ),
        );
      } catch (e) {
        print("eror");
        emit(MovieListState(errorMessage: "Data Failed to load"));
      }
    });
  }
}
