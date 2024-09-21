import 'package:bloc/bloc.dart';
import 'package:gw_chat/core/database.dart';
import 'package:gw_chat/core/model/city.dart';
import 'package:gw_chat/core/repository/cities_repository.dart';
import 'package:meta/meta.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(const CitiesState());

  Future<void> getCities({int? countyId}) async {
    if (countyId == null) {
      return;
    }
    if (!(await DataBaseService().isCityDataCached(countyId))) {
      return refreshCities(countyId: countyId);
    } else {
      emit(CitiesLoading(cities: state.cities));
      final cities =
          await DataBaseService().getAllCityCache(countryId: countyId);
      emit(CitiesState(cities: cities));
    }
  }

  Future<void> refreshCities({int? countyId}) async {
    if (countyId == null) {
      return;
    }
    emit(CitiesLoading(cities: state.cities));
    final resultCache =
        await DataBaseService().getAllCityCache(countryId: countyId);
    emit(CitiesLoading(cities: resultCache));
    final resultApi = await citiesRepository(countyId: countyId);

    if (resultApi != null) {
      emit(CitiesLoading(cities: resultApi));
      await Future.delayed(const Duration(seconds: 1));
      await DataBaseService().updateAllCityCache(resultApi, countyId);
    }
    final result = await DataBaseService().getAllCityCache(countryId: countyId);
    emit(CitiesState(cities: result));
  }
}

@immutable
final class CitiesState {
  final List<City> cities;

  const CitiesState({this.cities = const []});
}

final class CitiesLoading extends CitiesState {
  const CitiesLoading({super.cities});
}
