import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/user_list/user_list_event.dart';
import 'package:user_manage_app/bloc/user_list/user_list_state.dart';
import 'package:user_manage_app/repositories/user_list_repository.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserListRepository userRepository;

  UserListBloc(this.userRepository) : super(UserListState()) {
    on<GetUsers>((event, emit) async {
     
      try {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult.contains(ConnectivityResult.none)) {
          emit(
            UserListState(
              errorMessage:
                  'No internet connection. Please check your settings.',
            ),
          );
          return;
        }

        final users = await userRepository.fetchUsers(event.page);
        emit(
          UserListState(
            users: List.from(state.users)..addAll(users),
            hasReachedMax: users.isEmpty,
          ),
        );
      } catch (e) {
        // Handle error (optional)
        emit(UserListState(errorMessage: "Data Failed to load"));
      }
    });
  }
}
