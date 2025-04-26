import 'package:user_manage_app/model/user_offline_model.dart';

abstract class UserOfflineEvent {}

class AddUser  extends UserOfflineEvent {
  final UserOfflineModel user;

  AddUser(this.user);
}
