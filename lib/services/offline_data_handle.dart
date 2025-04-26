import 'dart:async';
import 'package:user_manage_app/widgets/helper.dart';
import 'package:user_manage_app/services/hive_services.dart';
import 'package:workmanager/workmanager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:user_manage_app/repositories/user_list_repository.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // After syncing, update the local database with the new ID
    handleOffileData();
    return Future.value(true);
  });
}

void checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains(ConnectivityResult.mobile)) {
    // Device is online, you can trigger sync if needed
    handleOffileData();
  }
}

void listenToConnectivityChanges() {
  Connectivity().onConnectivityChanged.listen((
    List<ConnectivityResult> result,
  ) {
    // Received changes in available connectivity types!
    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      CustomToast.show(message: "User back again");
      handleOffileData();
    }
  });
}

void handleOffileData() async {
  var box = await HiveService().getUserBox();
  for (var user in box.values) {
    final userId = await syncOfflineData(user.name, user.job);
    // Update the user ID in Hive
    // Show success toast

    CustomToast.show(message: "Data Synced Successfully.");
    user.id = userId.id;
    await box.put(user, user);
  }
}
