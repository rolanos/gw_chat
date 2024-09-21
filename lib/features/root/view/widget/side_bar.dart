import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/providers/locale_provider.dart';
import 'package:gw_chat/core/providers/theme_provider.dart';
import 'package:gw_chat/core/theme.dart';
import 'package:gw_chat/features/cities/view/cities_screen.dart';
import 'package:gw_chat/features/cities/view/cubit/cities_cubit.dart';
import 'package:gw_chat/features/countries/view/countries_screen.dart';
import 'package:gw_chat/features/countries/cubit/country_cubit.dart';
import 'package:gw_chat/features/social_media/view/cubit/chats_cubit.dart';
import 'package:gw_chat/features/social_media/view/social_media_sceen.dart';
import 'package:gw_chat/features/statistics/view/statistic_screen.dart';
import 'package:gw_chat/generated/l10n.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.theme.canvasColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.mediaQuerySize.height * 0.2,
          horizontal: context.mediaQuerySize.width * 0.05,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: AppConstants.p18),
            Row(
              children: [
                Text(
                  "RU",
                  style: context.theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AppConstants.p7),
                Switch(
                  value: Provider.of<LocaleProvider>(context).locale ==
                      S.delegate.supportedLocales.first,
                  onChanged: (value) {
                    if (value) {
                      Provider.of<LocaleProvider>(context, listen: false)
                          .setLocale(S.delegate.supportedLocales.first);
                    } else {
                      Provider.of<LocaleProvider>(context, listen: false)
                          .setLocale(S.delegate.supportedLocales.last);
                    }
                  },
                ),
                const SizedBox(height: AppConstants.p7),
                Text(
                  "EN",
                  style: context.theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.p10),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "Темная",
                    style: context.theme.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: AppConstants.p7),
                Switch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                          .theme ==
                      AppTheme.lightTheme,
                  onChanged: (value) async {
                    if (value) {
                      await Provider.of<ThemeProvider>(context, listen: false)
                          .setTheme(AppTheme.lightTheme);
                    } else {
                      await Provider.of<ThemeProvider>(context, listen: false)
                          .setTheme(AppTheme.darkTheme);
                    }
                  },
                ),
                const SizedBox(height: AppConstants.p7),
                Flexible(
                  child: Text(
                    "Светлая",
                    style: context.theme.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
