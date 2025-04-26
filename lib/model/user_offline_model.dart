//handle offline model

import 'package:hive/hive.dart';

part 'user_offline_model.g.dart';

@HiveType(typeId: 0)
class UserOfflineModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String job;

  @HiveField(2)
  String? id;

  UserOfflineModel({required this.name, required this.job, this.id});

  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job': job,
      'id': id, // Include ID if needed
    };
  }

  factory UserOfflineModel.fromJson(Map<String, dynamic> json) {
    return UserOfflineModel(
      name: json['name'],
      job: json['job'],
      id: json['id'], // Assuming the ID is included in the JSON
    );
  }
}