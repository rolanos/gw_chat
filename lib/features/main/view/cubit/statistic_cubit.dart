import 'package:bloc/bloc.dart';
import 'package:gw_chat/core/repository/all_time_users_repository.dart';
import 'package:gw_chat/core/repository/today_time_active_repository.dart';
import 'package:meta/meta.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit() : super(const StatisticState());

  getStatistics() async {
    emit(StatisticLoading(
        totalUsers: state.totalUsers, totalUsersToday: state.totalUsersToday));
    final totalUsersResult = await allTimeUsersRepository();
    final totalUsersTodayResult = await todayActiveUsersStatRepository();
    emit(StatisticState(
      totalUsers: totalUsersResult,
      totalUsersToday: totalUsersTodayResult,
    ));
  }
}

@immutable
final class StatisticState {
  final int? totalUsers;
  final int? totalUsersToday;

  const StatisticState({this.totalUsers, this.totalUsersToday});
}

@immutable
final class StatisticLoading extends StatisticState {
  const StatisticLoading({super.totalUsers, super.totalUsersToday});
}
