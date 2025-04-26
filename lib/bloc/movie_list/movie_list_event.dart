class MovieListEvent {}

class FetchMovies extends MovieListEvent {
  final int page;

  FetchMovies(this.page);
}