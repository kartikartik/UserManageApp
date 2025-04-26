// Define the Movie detail model
class MovieDetailModel {
  final String title;
  final String description;
  final String releaseDate;
  final String posterPath;

  MovieDetailModel({required this.title, required this.description, required this.releaseDate, required this.posterPath});

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      title: json['title'],
      description: json['overview'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
    );
  }
}