class MovieListModel {
  final String title;
  final String posterPath;
  final String releaseDate;
  final int id;

  MovieListModel({
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.id
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) {
    return MovieListModel(
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      id: json['id'],
    );
  }
}
