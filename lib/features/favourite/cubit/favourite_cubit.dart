import 'package:bloc/bloc.dart';
import 'package:gw_chat/core/database.dart';
import 'package:gw_chat/core/model/favourite_model.dart';
import 'package:meta/meta.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(const FavouriteState());

  getData() async {
    final result = await DataBaseService().getAllFavouritesCache();
    emit(FavouriteState(data: result));
  }

  tickContains(
    int id,
    String? name,
    String? wikiUrl,
    String? flagUrl,
    String? classType,
  ) async {
    await DataBaseService().changeFavourite(
      id,
      name,
      wikiUrl,
      flagUrl,
      classType,
    );
    await getData();
  }

  checkContainsId(int? id) => id != null
      ? state.data.where((element) => element.id == id).isNotEmpty
      : false;
}

@immutable
class FavouriteState {
  final List<FavouriteModel> data;

  const FavouriteState({
    this.data = const [],
  });

  FavouriteState copyWith({
    List<FavouriteModel>? data,
  }) {
    return FavouriteState(
      data: data ?? this.data,
    );
  }
}
