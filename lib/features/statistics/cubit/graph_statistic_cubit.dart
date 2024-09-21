import 'package:bloc/bloc.dart';
import 'package:gw_chat/core/model/country.dart';
import 'package:gw_chat/core/model/user_list.dart';
import 'package:gw_chat/core/repository/today_active_users_repository.dart';
import 'package:meta/meta.dart';

class GraphStatisticCubit extends Cubit<GraphStatisticState> {
  GraphStatisticCubit() : super(const GraphStatisticState());

  getData({Country? country}) async {
    emit(
      GraphStatisticLoading(
        country: country,
        people: state.people,
        countries: state.countries,
      ),
    );
    final people = await graphStatisticActiveUsersRepository();
    var countries = people;
    if (country?.countryId != null) {
      countries = await graphStatisticActiveUsersRepository(
          countryId: country?.countryId);
    }
    emit(
      GraphStatisticState(
        country: country,
        people: people ?? state.people,
        countries: countries ?? state.people,
      ),
    );
  }

  pastCountry(List<Country> countries) async {
    Country? nextCountry;
    if (state.country?.countryId == null) {
      return;
    }
    final currentId = countries
        .indexWhere((element) => element.countryId == state.country?.countryId);
    if (currentId != -1 && currentId != 0) {
      nextCountry = countries[currentId - 1];
    }
    await getData(country: nextCountry);
  }

  nextCountry(List<Country> countries) async {
    Country? nextCountry;
    if (state.country?.countryId == null) {
      nextCountry = countries.isNotEmpty ? countries.first : null;
      await getData(country: nextCountry);
      return;
    }
    final currentId = countries
        .indexWhere((element) => element.countryId == state.country?.countryId);
    if (currentId != -1 && currentId != countries.length - 1) {
      nextCountry = countries[currentId + 1];
    }
    await getData(country: nextCountry);
  }
}

@immutable
final class GraphStatisticState {
  final UserList people;
  final UserList countries;
  final Country? country;

  const GraphStatisticState({
    this.people = const UserList(),
    this.countries = const UserList(),
    this.country,
  });
}

@immutable
final class GraphStatisticLoading extends GraphStatisticState {
  const GraphStatisticLoading({
    super.people,
    super.countries,
    super.country,
  });
}
