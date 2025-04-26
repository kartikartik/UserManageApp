import 'package:user_manage_app/model/user_list_model.dart';

// Define the User list State
class UserListState {
  final List<UserList> users;
  final bool hasReachedMax;

  UserListState({this.users = const [], this.hasReachedMax = false});
}
