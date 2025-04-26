// Define the User List Event
abstract class UserListEvent {}

class GetUsers extends UserListEvent {
  final int page;

  GetUsers(this.page);
}