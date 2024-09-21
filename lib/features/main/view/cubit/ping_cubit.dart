import 'package:bloc/bloc.dart';
import 'package:gw_chat/core/repository/ping_repository.dart';
import 'package:meta/meta.dart';

class PingCubit extends Cubit<PingState> {
  PingCubit() : super(const PingState());

  callPing({int? countryId}) async {
    final noError = await ping(countryId: countryId);
    emit(PingState(hasError: !noError));
  }
}

@immutable
final class PingState {
  const PingState({this.hasError = false});

  final bool hasError;
}
