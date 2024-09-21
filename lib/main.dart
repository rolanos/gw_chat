import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gw_chat/core/providers/theme_provider.dart';
import 'package:gw_chat/features/cities/view/cubit/cities_cubit.dart';
import 'package:gw_chat/features/countries/cubit/country_cubit.dart';
import 'package:gw_chat/features/main/view/cubit/ping_cubit.dart';
import 'package:gw_chat/features/main/view/cubit/statistic_cubit.dart';
import 'package:gw_chat/features/root/view/root_screen.dart';
import 'package:provider/provider.dart';
import 'core/database.dart';
import 'core/theme.dart';
import 'features/favourite/cubit/favourite_cubit.dart';
import 'features/social_media/view/cubit/chats_cubit.dart';
import 'features/statistics/cubit/graph_statistic_cubit.dart';
import 'generated/l10n.dart';
import 'core/providers/locale_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final locale = LocaleProvider();
  final theme = ThemeProvider(AppTheme.lightTheme);
  await theme.setCachedTheme();
  await locale.setCachedLocale();
  await DataBaseService().db;
  runApp(
    MyApp(
      locale: locale,
      theme: theme,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.locale,
    required this.theme,
  });

  final LocaleProvider locale;

  final ThemeProvider theme;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => theme,
      builder: (context, child) => ChangeNotifierProvider(
        create: (context) => locale,
        builder: (context, child) => MaterialApp(
          title: 'GWChat',
          debugShowCheckedModeBanner: false,
          locale: Provider.of<LocaleProvider>(context).locale,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: Provider.of<ThemeProvider>(context).theme,
          home: FutureBuilder(
              future: Provider.of<ThemeProvider>(context).setCachedTheme(),
              builder: (context, _) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          CountryCubit()..getCountries(needsRefresh: true),
                    ),
                    BlocProvider(
                      create: (context) => StatisticCubit()..getStatistics(),
                    ),
                    BlocProvider(
                      create: (context) => CitiesCubit(),
                    ),
                    BlocProvider(
                      lazy: false,
                      create: (context) => PingCubit()..callPing(),
                    ),
                    BlocProvider(
                      lazy: false,
                      create: (context) => GraphStatisticCubit()..getData(),
                    ),
                    BlocProvider(
                      create: (context) => ChatsCubit(),
                    ),
                    BlocProvider(
                      lazy: false,
                      create: (context) => FavouriteCubit()..getData(),
                    ),
                  ],
                  child: const RootScreen(),
                );
              }),
        ),
      ),
    );
  }
}
