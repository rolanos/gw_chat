import 'package:bloc/bloc.dart';
import 'package:gw_chat/core/model/chat.dart';
import 'package:gw_chat/core/repository/chats_repository.dart';
import 'package:meta/meta.dart';

class ChatsCubit extends Cubit<ChetsState> {
  ChatsCubit() : super(const ChetsState());

  getChats(int cityId) async {
    emit(const ChetsLoading());
    final result = await chatRepository(cityId: cityId);
    emit(ChetsState(chats: result ?? state.chats));
  }
}

@immutable
final class ChetsState {
  final List<Chat> chats;

  const ChetsState({this.chats = const []});
}

final class ChetsLoading extends ChetsState {
  const ChetsLoading({super.chats});
}
