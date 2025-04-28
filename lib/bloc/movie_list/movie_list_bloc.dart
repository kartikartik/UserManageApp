import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/movie_list/movie_list_event.dart';
import 'package:user_manage_app/bloc/movie_list/movie_list_state.dart';
import 'package:user_manage_app/repositories/movie_repository.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository movieRepository;

  MovieListBloc(this.movieRepository) : super(MovieListState()) {
    on<FetchMovies>((event, emit) async {
      // Fetch movies when the event is triggered
      try {
         final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult.contains(ConnectivityResult.none)) {
          emit(
            MovieListState(
              errorMessage:
                  'No internet connection. Please check your settings.',
            ),
          );
          return;
        }


        final movies = await movieRepository.fetchMovies(event.page);
        emit(
          MovieListState(
            movies: List.from(state.movies)..addAll(movies),
            hasReachedMax: movies.isEmpty,
          ),
        );
      } catch (e) {
        emit(MovieListState(errorMessage: "Data Failed to load"));
      }
    });
  }
}
