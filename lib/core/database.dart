import 'dart:developer';

import 'package:gw_chat/core/translator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:gw_chat/core/model/chat.dart';
import 'package:gw_chat/core/model/city.dart';
import 'package:gw_chat/core/model/country.dart';
import 'package:gw_chat/core/model/favourite_model.dart';

enum TableName {
  county('county'),
  city('city'),
  favourite('favourite');

  const TableName(this.name);

  final String name;
}

abstract class DatabaseInterface {
  //SELECT *

  ///Получение всех
  Future<List<City>> getAllCityCache();
  Future<List<Chat>> getAllChatsCache();
  Future<List<Country>> getAllCountryCache();
  Future<List<FavouriteModel>> getAllFavouritesCache();

  Future<void> updateAllCityCache(List<City> cities, int countryId);
  Future<void> updateAllChatsCache(List<Chat> chats);
  Future<void> updateAllCountryCache(List<Country> countryes);
  Future<void> updateAllFavouritesCache(List<FavouriteModel> favourites);

  Future<void> changeFavourite(
    int id,
    String? name,
    String? wikiUrl,
    String? flagUrl,
    String? classType,
  );

  Future<bool> isCountryDataCached();
}

class DataBaseService implements DatabaseInterface {
  Database? _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await _init();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'gwchat.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _init() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await database.execute('''
    CREATE TABLE ${TableName.county.name} (
      country_id INTEGER PRIMARY KEY,
      country_name TEXT(50),
      ru_country_name TEXT(100),
      wiki TEXT(150),
      flag TEXT(150)
    );
''');
    await database.execute('''
    CREATE TABLE ${TableName.city.name} (
    city_id INTEGER PRIMARY KEY,
    city_name TEXT(200),
    ru_city_name TEXT(200),
    country_id INTEGER
    );  
''');
    await database.execute('''
    CREATE TABLE ${TableName.favourite.name} (
    id INTEGER PRIMARY KEY,
    name TEXT(250),
    wikiUrl TEXT(200),
    flagUrl TEXT(200),
    classType TEXT(50)
);  
''');
  }

  @override
  Future<List<City>> getAllCityCache({int? countryId}) async {
    try {
      final database = await db;
      final data = await database.query(
        TableName.city.name,
        where: 'country_id = ?',
        whereArgs: [
          countryId,
        ],
      );
      return List.generate(
        data.length,
        (index) => City.fromJson(data[index]),
      );
    } catch (e) {
      log(e.toString());
      log('Ошибка getAllCityCache: запрос в получении городов');
    }
    return [];
  }

  @override
  Future<List<Chat>> getAllChatsCache() {
    // TODO: implement getAllChatsCache
    throw UnimplementedError();
  }

  @override
  Future<List<Country>> getAllCountryCache() async {
    try {
      final database = await db;
      final data = await database.query(TableName.county.name);
      return List.generate(
        data.length,
        (index) => Country.fromJson(data[index]),
      );
    } catch (e) {
      log(e.toString());
      log('Ошибка getAllCountryCache: запрос в получении стран');
    }
    return [];
  }

  @override
  Future<List<FavouriteModel>> getAllFavouritesCache() async {
    try {
      final database = await db;
      final data = await database.query(TableName.favourite.name);
      return List.generate(
        data.length,
        (index) => FavouriteModel.fromJson(data[index]),
      );
    } catch (e) {
      log(e.toString());
      log('Ошибка getAllFavouritesCache: запрос в получении закладок');
    }
    return [];
  }

  @override
  Future<void> updateAllChatsCache(List<Chat> chats) async {}

  @override
  Future<void> updateAllCountryCache(List<Country> countries) async {
    try {
      final database = await db;
      for (var country in countries) {
        final res = await database.update(
          TableName.county.name,
          country.toJsonUpdate(),
          where: 'country_id = ?',
          whereArgs: [country.countryId],
        );
        if (res == 0) {
          final transl = await translate(country.countryName ?? '');
          final newCountry = Country(
            countryName: country.countryName,
            ruCountryName: transl,
            countryId: country.countryId,
            wiki: country.wiki,
            flag: country.flag,
          );
          await database.insert(
            TableName.county.name,
            newCountry.toJson(),
          );
        }
      }
    } catch (e) {
      log(e.toString());
      log('Ошибка updateAllCountryCache: запрос в обновлении стран');
    }
  }

  @override
  Future<void> updateAllFavouritesCache(List<FavouriteModel> favourites) async {
    try {
      final database = await db;
      for (var favourite in favourites) {
        final res = await database.update(
          TableName.favourite.name,
          favourite.toJson(),
          where: 'id = ?',
          whereArgs: [favourite.id],
        );
        if (res == 0) {
          await database.insert(
            TableName.favourite.name,
            favourite.toJson(),
          );
        }
      }
    } catch (e) {
      log(e.toString());
      log('Ошибка updateAllFavouritesCache: запрос в обновлении закладок');
    }
  }

  @override
  Future<void> updateAllCityCache(List<City> cities, int countryId) async {
    try {
      final database = await db;
      for (var city in cities) {
        final res = await database.update(
          TableName.city.name,
          city.toJsonUpdate(),
          where: 'city_id = ?',
          whereArgs: [city.cityId],
        );
        if (res == 0) {
          final transl = await translate(city.cityName ?? '');
          final newCity = City(
            cityName: city.cityName,
            ruCityName: transl,
            cityId: city.cityId,
          );
          final q = await database.query(
            TableName.city.name,
            where: 'city_id = ?',
            whereArgs: [newCity.cityId],
          );
          if (q.isEmpty) {
            final map = newCity.toJson()
              ..addAll({
                "country_id": countryId,
              });
            await database.insert(
              TableName.city.name,
              map,
            );
          }
        }
      }
    } catch (e) {
      log(e.toString());
      log('Ошибка updateAllCityCache: запрос в обновлении стран');
    }
  }

  @override
  Future<void> changeFavourite(
    int id,
    String? name,
    String? wikiUrl,
    String? flagUrl,
    String? classType,
  ) async {
    try {
      final database = await db;
      final result = await database.query(
        TableName.favourite.name,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result.isNotEmpty) {
        await database.delete(
          TableName.favourite.name,
          where: 'id = ?',
          whereArgs: [id],
        );
      } else {
        await database.insert(
          TableName.favourite.name,
          {
            "id": id,
            "name": name,
            "wikiUrl": wikiUrl,
            "flagUrl": flagUrl,
            "classType": classType,
          },
        );
      }
    } catch (e) {
      log(e.toString());
      log('Ошибка в обновлении changeFavourite: запрос в обновлении закладок');
    }
  }

  @override
  Future<bool> isCountryDataCached() async {
    try {
      final database = await db;
      final result = await database.query(
        TableName.county.name,
      );
      return result.isNotEmpty;
    } catch (e) {
      log(e.toString());
      log('Ошибка в обновлении isDataCached: запрос на проверку инициализации данных');
    }
    return false;
  }

  Future<bool> isCityDataCached(int countryId) async {
    try {
      final database = await db;
      final result = await database.query(
        TableName.city.name,
        where: 'country_id = ?',
        whereArgs: [
          countryId,
        ],
      );
      return result.isNotEmpty;
    } catch (e) {
      log(e.toString());
      log('Ошибка в обновлении isDataCached: запрос на проверку инициализации данных');
    }
    return false;
  }
}
