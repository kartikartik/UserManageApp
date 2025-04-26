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

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _currentPage++;
        context.read<UserListBloc>().add(GetUsers(_currentPage));
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
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state.users.isEmpty) {
            return Center(child: Text('No users found'));
          }

          if (state.users.isEmpty && state.hasReachedMax == false) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount:
                state.hasReachedMax
                    ? state.users.length
                    : state.users.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.users.length) {
                return Center(child: CircularProgressIndicator());
              }
              final user = state.users[index];
              return ListTile(
                leading: CachedNetworkImageExtension.customImage(
                  imageUrl: user.avatar,
                  width: 100,
                  height: 100,
                  placeholderColor: Colors.blue, 
                  errorColor: Colors.red,
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
          );
        },
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
