import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/movie_details/movie_detail_bloc.dart';
import 'package:user_manage_app/bloc/movie_details/movie_detail_event.dart';
import 'package:user_manage_app/bloc/movie_details/movie_detail_state.dart';
import 'package:user_manage_app/services/get_it_dp.dart';
import 'package:user_manage_app/widgets/helper.dart';
import 'package:user_manage_app/utils/constants.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
        backgroundColor: Colors.transparent, elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => getIt<MovieDetailBloc>()..add(FetchMovieDetail(movieId)),
        child: MovieDetailView(),
      ),
    );
  }
}

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state.movie == null && state.errorMessage == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text('${state.errorMessage}'));
        }

        final movie = state.movie!;
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: CachedNetworkImageExtension.customImage(
                    imageUrl: '$movieImage${movie.posterPath}',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    placeholderColor: Colors.blue,
                    errorColor: Colors.red,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  movie.title,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 8),
                Text(
                  'Release Date: ${movie.releaseDate}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 8),
                Text(
                  movie.description,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}