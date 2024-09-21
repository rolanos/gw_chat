import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class User extends Equatable {
  final String? time;
  final int? amount;

  const User({
    required this.time,
    required this.amount,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        time: json["time"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "amount": amount,
      };

  @override
  List<Object?> get props => [
        time,
        amount,
      ];
}
