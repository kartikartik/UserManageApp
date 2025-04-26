import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/movie/movieList/movie_list_bloc.dart';
import 'package:user_manage_app/bloc/userList/user_list_bloc.dart';
import 'package:user_manage_app/screens/movie/movie_list_screen.dart';
import 'package:user_manage_app/screens/user_list_screen.dart';
import 'package:user_manage_app/services/get_it_dp.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List App',
      home:
      // BlocProvider(
      //   create: (context) => getIt<UserListBloc>(), // Provide the UserBloc
      //   child: UserListScreen(),
      // ),
      BlocProvider(
        create: (context) => getIt<MovieListBloc>(), // Provide the UserBloc
        child: MovieListScreen(),
      ),
    );
  }
}
