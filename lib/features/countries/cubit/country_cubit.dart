import 'package:bloc/bloc.dart';
import 'package:gw_chat/core/database.dart';
import 'package:meta/meta.dart';

import 'package:gw_chat/core/model/country.dart';
import 'package:gw_chat/core/repository/countries_repository.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(const CountryState());

  getCountries({bool needsRefresh = false}) async {
    emit(CountryLoading(countries: state.countries));
    if (!(await DataBaseService().isCountryDataCached()) || needsRefresh) {
      return refreshCountries();
    } else {
      final countries = await DataBaseService().getAllCountryCache();
      emit(CountryState(countries: countries));
    }
  }

  refreshCountries() async {
    emit(CountryLoading(countries: state.countries));
    final countriesCache = await DataBaseService().getAllCountryCache();
    emit(CountryLoading(countries: countriesCache));
    final countriesNew = await countriesRepository();
    if (countriesNew != null) {
      emit(CountryLoading(countries: countriesNew));
      await DataBaseService().updateAllCountryCache(countriesNew);
    }
    final countries = await DataBaseService().getAllCountryCache();
    emit(CountryState(countries: countries));
  }
}

@immutable
final class CountryState {
  final List<Country> countries;

  const CountryState({this.countries = const []});
}

@immutable
final class CountryLoading extends CountryState {
  const CountryLoading({super.countries});
}
