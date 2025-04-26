

import 'package:user_manage_app/model/user_offline_model.dart';

abstract class UserOfflineState {}

class UserInitial extends UserOfflineState {}

class UserLoading extends UserOfflineState {}

class UserLoaded extends UserOfflineState {
  final List<UserOfflineModel> users;

  UserLoaded(this.users);
}

class UserError extends UserOfflineState {
  final String message;

  UserError(this.message);
}