class UserList {
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;

  UserList({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
