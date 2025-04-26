import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:user_manage_app/bloc/movie/movieDetails/movie_detail_bloc.dart';
import 'package:user_manage_app/bloc/movie/movieList/movie_list_bloc.dart';
import 'package:user_manage_app/bloc/userList/user_list_bloc.dart';
import 'package:user_manage_app/model/user_offline_model.dart';
import 'package:user_manage_app/services/offline_data_handle.dart';
import 'package:user_manage_app/services/user_list_repository.dart';
import 'package:workmanager/workmanager.dart';

final getIt = GetIt.instance;

void setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  ); // Initialize WorkManager in your main function
  Hive.initFlutter();
  Hive.registerAdapter(UserOfflineModelAdapter());

  // Register your repositories
  getIt.registerLazySingleton<UserListRepository>(() => UserListRepository());
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepository());

  // Register your blocs
  getIt.registerFactory<UserListBloc>(
    () => UserListBloc(getIt<UserListRepository>()),
  );
  getIt.registerFactory<MovieListBloc>(
    () => MovieListBloc(getIt<MovieRepository>()),
  );
  getIt.registerFactory<MovieDetailBloc>(
    () => MovieDetailBloc(getIt<MovieRepository>()),
  );

  checkConnectivity();
  listenToConnectivityChanges();
}
