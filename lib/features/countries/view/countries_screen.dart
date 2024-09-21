import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/features/countries/cubit/country_cubit.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:gw_chat/features/root/view/widget/app_bar.dart';
import 'package:gw_chat/features/root/view/widget/side_bar.dart';
import 'package:gw_chat/generated/l10n.dart';
import 'package:loadmore/loadmore.dart';

import 'widget/country_row.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  int currentSize = 0;

  final ScrollController scrollController = ScrollController();

  bool isInitedListener = false;

  int size = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideBar(),
      appBar: rootAppBar(context),
      body: Container(
        color: context.theme.canvasColor,
        child: RefreshIndicator(
          onRefresh: () async =>
              context.read<CountryCubit>().refreshCountries(),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppConstants.p20,
                    bottom: AppConstants.p20,
                    top: AppConstants.p25,
                  ),
                  child: Text(
                    S.of(context).countries,
                    style: context.theme.textTheme.titleSmall,
                  ),
                ),
                const Divider(height: 0),
                BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, state) {
                    if (!isInitedListener) {
                      scrollController.addListener(_listenScroll);
                      isInitedListener = true;
                    }
                    return BlocBuilder<CountryCubit, CountryState>(
                      builder: (context, state) {
                        size = state.countries.length;
                        if (currentSize == 0) {
                          currentSize = size > 20 ? 20 : size;
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<FavouriteCubit>(),
                              ),
                            ],
                            child: CountryRow(
                              countryModel: state.countries[index],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              const Divider(height: 0),
                          itemCount: currentSize,
                        );
                      },
                    );
                  },
                ),
                const Divider(height: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _changeSize() async {
    if (size - 20 >= currentSize) {
      currentSize += 20;
    } else {
      currentSize = size;
    }
  }

  _listenScroll() {
    if (scrollController.position.maxScrollExtent - 24 <=
        scrollController.offset) {
      _changeSize();
      setState(() {});
    }
  }
}
