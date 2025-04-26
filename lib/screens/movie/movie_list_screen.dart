import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/movie_details/movie_detail_bloc.dart';
import 'package:user_manage_app/bloc/movie_list/movie_list_bloc.dart';
import 'package:user_manage_app/bloc/movie_list/movie_list_event.dart';
import 'package:user_manage_app/bloc/movie_list/movie_list_state.dart';
import 'package:user_manage_app/screens/movie/movie_detail_screen.dart';
import 'package:user_manage_app/services/get_it_dp.dart';
import 'package:user_manage_app/widgets/helper.dart';
import 'package:user_manage_app/utils/constants.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
        backgroundColor: Colors.transparent,elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => getIt<MovieListBloc>()..add(FetchMovies(1)),
        child: MovieListView(),
      ),
    );
  }
}

class MovieListView extends StatefulWidget {
  const MovieListView({super.key});

  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _currentPage++;
        context.read<MovieListBloc>().add(FetchMovies(_currentPage));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        if (state.movies.isEmpty && state.errorMessage == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text('${state.errorMessage}'));
        }

        return GridView.builder(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: state.hasReachedMax
              ? state.movies.length
              : state.movies.length + 1,
          itemBuilder: (context, index) {
            if (index >= state.movies.length) {
              return Center(child: CircularProgressIndicator());
            }
            final movie = state.movies[index];
            return Card(
              elevation: 4,
              child: InkWell(
                onTap: () {
                  // Navigate to Movie Detail Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: getIt<MovieDetailBloc>(),
                        child: MovieDetailScreen(movieId: movie.id),
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImageExtension.customImage(
                      imageUrl: '$movieImage${movie.posterPath}',
                      width: double.infinity,
                      height: 120,
                      placeholderColor: Colors.blue,
                      errorColor: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        movie.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        movie.releaseDate,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            );
 },
        );
      },
    );
  }
}