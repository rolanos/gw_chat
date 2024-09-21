import 'package:equatable/equatable.dart';
import 'package:gw_chat/core/model/user.dart';
import 'package:meta/meta.dart';

@immutable
class UserList extends Equatable {
  final List<User> users;

  const UserList({
    this.users = const [],
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map = {};
    var result = UserList(
      users: [],
    );
    final uList = UserList(
      users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );
    for (var i = 0; i < 25; i++) {
      map.addAll({
        i.toString(): 0,
      });
    }
    for (var user in uList.users) {
      if (user.time != null) {
        map[user.time!] = user.amount ?? 0;
      }
    }
    for (var mapBuffer in map.entries) {
      result.users.add(User(time: mapBuffer.key, amount: mapBuffer.value));
    }
    result.users.sort((a, b) =>
        int.tryParse(a.time ?? '')
            ?.compareTo(int.tryParse(b.time ?? '') ?? 0) ??
        0);
    return result;
  }

  @override
  List<Object?> get props => [users];
}
