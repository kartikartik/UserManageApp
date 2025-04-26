import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/userOffline/user_offline_event.dart';
import 'package:user_manage_app/bloc/userOffline/user_offline_state.dart';
import 'package:user_manage_app/services/hive_services.dart';
import 'package:user_manage_app/services/user_list_repository.dart';

class UserOfflineBloc extends Bloc<UserOfflineEvent, UserOfflineState> {
  UserOfflineBloc() : super(UserInitial()) {
    on<AddUser>((event, emit) async {
      emit(UserLoading());
      try {
        // Check for internet connectivity
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult.contains(ConnectivityResult.wifi)) {
          final user = await syncOfflineData(event.user.name, event.user.job);

          emit(UserLoaded([user]));
        } else {
          // Store in Hive if offline
          var box = await HiveService().getUserBox();

          await box.add(event.user);

          if (event.user.name.isEmpty) {
            emit(UserError('Failed to create user'));
          }
          emit(UserLoaded([event.user])); // Update the state with the new user
        }
      } catch (e) {
        emit(UserError('Failed to create user'));
      }
    });
  }
}
