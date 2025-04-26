// Define the Movie Detail BLoC

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/movie_details/movie_detail_event.dart';
import 'package:user_manage_app/bloc/movie_details/movie_detail_state.dart';
import 'package:user_manage_app/repositories/movie_repository.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
   final MovieRepository movieRepository;
  MovieDetailBloc(this.movieRepository) : super(MovieDetailState()) {
    on<FetchMovieDetail>((event, emit) async {
      try {
        final movie = await movieRepository.fetchMovieDetail(event.movieId);
        emit(MovieDetailState(movie: movie));
      } catch (e) {
        emit(MovieDetailState(errorMessage: 'Data Failed to load'));
      }
    });
  }
}
