import 'package:hive/hive.dart';
import 'package:user_manage_app/model/user_offline_model.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  static Box<UserOfflineModel>? _userBox;

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  Future<Box<UserOfflineModel>> getUserBox() async {
    _userBox ??= await Hive.openBox<UserOfflineModel>('users');
    return _userBox!;
  }

  Future<void> closeUserBox() async {
    if (_userBox != null && Hive.isBoxOpen('users')) {
      await _userBox!.close();
      _userBox = null; // Reset the box reference
    }
  }
}