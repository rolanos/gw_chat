import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/model/country.dart';
import 'package:gw_chat/features/cities/view/cubit/cities_cubit.dart';
import 'package:gw_chat/features/cities/view/widget/city_row.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:gw_chat/features/root/view/widget/app_bar.dart';
import 'package:gw_chat/features/root/view/widget/side_bar.dart';
import 'package:gw_chat/generated/l10n.dart';

class CitiesScreen extends StatefulWidget {
  const CitiesScreen({super.key, required this.countryModel});

  final Country countryModel;

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
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
          onRefresh: () async => context
              .read<CitiesCubit>()
              .refreshCities(countyId: widget.countryModel.countryId),
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
                  child: Row(
                    children: [
                      Text(
                        S.of(context).cities,
                        style: context.theme.textTheme.titleSmall,
                      ),
                      const SizedBox(width: AppConstants.p7),
                    ],
                  ),
                ),
                const Divider(height: 0),
                BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, state) {
                    return BlocBuilder<CitiesCubit, CitiesState>(
                      builder: (context, state) {
                        size = state.cities.length;
                        if (currentSize == 0) {
                          currentSize = size > 20 ? 20 : size;
                        }
                        if (currentSize > size) {
                          currentSize = size;
                        }
                        if (state is CitiesLoading && state.cities.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.p16,
                                vertical: AppConstants.p16,
                              ),
                              child: CircularProgressIndicator(
                                color: context.theme.cardColor,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => CityRow(
                            city: state.cities[index],
                            countryModel: widget.countryModel,
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
