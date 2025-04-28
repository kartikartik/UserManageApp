import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_manage_app/model/user_list_model.dart';
import 'package:user_manage_app/model/user_offline_model.dart';
import 'package:user_manage_app/utils/constants.dart';
import 'package:user_manage_app/widgets/helper.dart';

class UserListRepository {
  Future<List<UserList>> fetchUsers(int page) async {
    final response = await http.get(
      Uri.parse('$userListUrl?page=$page'),
      headers: {'x-api-key': 'reqres-free-v1'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data == null) {
        throw Exception('No data returned from API');
      }

      return (data['data'] as List)
          .map((user) => UserList.fromJson(user))
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

Future<UserOfflineModel> syncOfflineData(String name, String job) async {
  final response = await http.post(
    Uri.parse(userListUrl),
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': 'reqres-free-v1',
    },
    body: jsonEncode({'name': name, 'job': job}),
  );

  if (response.statusCode == 201) {
    final newUser = UserOfflineModel.fromJson(jsonDecode(response.body));

    return newUser;
  } else {
    CustomToast.show(message: 'Failed to create users');
    throw Exception('Failed to create users');
  }
}
