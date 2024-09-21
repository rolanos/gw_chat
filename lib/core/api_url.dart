const String baseUrl = 'http://45.147.177.227:8082/api';

///GET Получение всех стран /ping/{country_id}
///country_id = -1 –– если просто зашел, иначен id страны если зашел по конкретной стране
const String pingUrl = '$baseUrl/ping/';

///GET Получение всех стран пользователей за все время
const String allTimeActiveUsers = '$baseUrl/all_time_active_users';

///GET Получение всех пользователей за сегодня
///ИЛИ {country_id} по определенной стране
const String graphStatisticActiveUsers =
    '$baseUrl/graph_stat/today_active_users';

///GET Получение всех пользователей за сегодня
const String todayTimeActiveUsers = '$baseUrl/today_time_active_users';

///GET Получение всех пользователей за сегодня
////chats/{city_id}
const String chatsUrl = '$baseUrl/chats/';

///GET Получение всех стран
const String countriesUrl = '$baseUrl/countries';

///GET /chats/{country_id} Получение всех городов по id страны
const String citiesUrl = '$baseUrl/cities/';
