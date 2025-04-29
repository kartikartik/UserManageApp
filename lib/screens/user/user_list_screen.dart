import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/movie_list/movie_list_bloc.dart';
import 'package:user_manage_app/bloc/user_list/user_list_bloc.dart';
import 'package:user_manage_app/bloc/user_list/user_list_event.dart';
import 'package:user_manage_app/bloc/user_list/user_list_state.dart';
import 'package:user_manage_app/bloc/user_offline/user_offline_bloc.dart';
import 'package:user_manage_app/screens/movie/movie_list_screen.dart';
import 'package:user_manage_app/screens/user/user_offline_add_screen.dart';
import 'package:user_manage_app/services/get_it_dp.dart';
import 'package:user_manage_app/widgets/helper.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => getIt<UserListBloc>(),
        child: UserListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider.value(
                    value: getIt<UserOfflineBloc>(),
                    child: UserOfflineAddScreen(),
                  ),
            ),
          );
        },
        tooltip: 'Create User',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late UserListBloc _userBloc;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _userBloc = getIt<UserListBloc>();
    _userBloc.add(GetUsers(_currentPage));
  }

  @override
  void dispose() {
    getIt.unregister<UserListBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserListState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state.users.isEmpty && state.errorMessage == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text('${state.errorMessage}'));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!state.hasReachedMax &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              _currentPage++;
              _userBloc.add(GetUsers(_currentPage));
            }
            return false;
          },
          child: ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return ListTile(
                leading: ClipOval(
                  child: CachedNetworkImageExtension.customImage(
                    imageUrl: user.avatar,
                    width: 50,
                    height: 50,
                    placeholderColor: Colors.blue,
                    errorColor: Colors.red,
                  ),
                ),
                title: Text('${user.firstName} ${user.lastName}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider.value(
                            value: getIt<MovieListBloc>(),
                            child: MovieListScreen(),
                          ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
