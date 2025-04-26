// Define the Movie Detail State
import 'package:user_manage_app/model/movie_detail_model.dart';

class MovieDetailState {
  final MovieDetailModel? movie;
final String? errorMessage;

  MovieDetailState({this.movie,this.errorMessage});
}