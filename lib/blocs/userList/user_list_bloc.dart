import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/user_list/user_list_event.dart';
import 'package:user_manage_app/bloc/user_list/user_list_state.dart';
import 'package:user_manage_app/repositories/user_list_repository.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserListRepository userRepository;

  UserListBloc(this.userRepository) : super(UserListState(users: [])) {
    on<GetUsers>((event, emit) async {
      if (state.hasReachedMax) return;

      try {
        final users = await userRepository.fetchUsers(event.page);
        emit(
          UserListState(
            users: List.from(state.users)..addAll(users),
            hasReachedMax: users.isEmpty,
          ),
        );
      } catch (e) {
        // Handle error (optional)
        print('Error fetching users: $e');
      }
    });
  }
}
