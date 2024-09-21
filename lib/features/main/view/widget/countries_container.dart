import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/providers/locale_provider.dart';
import 'package:gw_chat/core/translator.dart';
import 'package:gw_chat/features/cities/view/cubit/cities_cubit.dart';
import 'package:gw_chat/features/countries/view/countries_screen.dart';
import 'package:gw_chat/features/countries/cubit/country_cubit.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:gw_chat/features/main/view/cubit/ping_cubit.dart';
import 'package:gw_chat/features/social_media/view/cubit/chats_cubit.dart';

import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';

class CountriesContainer extends StatefulWidget {
  const CountriesContainer({super.key});

  @override
  State<CountriesContainer> createState() => _CountriesContainerState();
}

class _CountriesContainerState extends State<CountriesContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.p42,
      ),
      decoration: BoxDecoration(
        color: context.theme.canvasColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(
            AppConstants.p20,
          ),
        ),
      ),
      child: const Column(
        children: [
          CaruselWidget(isFirst: true),
          SizedBox(height: AppConstants.p22),
          CaruselWidget(
            reversed: true,
          ),
          SizedBox(height: AppConstants.p22),
          CaruselWidget(),
        ],
      ),
    );
  }
}

//TODO убрать с API
class CountryModel {
  final String name;
  final String path;

  CountryModel({required this.name, required this.path});
}

class CaruselWidget extends StatefulWidget {
  const CaruselWidget({
    super.key,
    this.reversed = false,
    this.isFirst = false,
  });

  final bool reversed;
  final bool isFirst;

  @override
  State<CaruselWidget> createState() => _CaruselWidgetState();
}

class _CaruselWidgetState extends State<CaruselWidget> {
  final List<CountryModel> countries = [
    CountryModel(
      name: 'UK',
      path: IconRoute.uk,
    ),
  ];

  final scrollController = InfiniteScrollController();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 1750), (timer) {
      if (widget.reversed) {
        scrollController.previousItem(
            duration: const Duration(milliseconds: 1750), curve: Curves.linear);
      } else {
        scrollController.nextItem(
            duration: const Duration(milliseconds: 1750), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context);
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if (state is CountryLoading &&
            state.countries.isEmpty &&
            widget.isFirst) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(
                AppConstants.p10,
              ),
              child: CircularProgressIndicator(
                color: context.theme.cardColor,
              ),
            ),
          );
        }
        if (state.countries.isEmpty) {
          return const SizedBox();
        }
        return SizedBox(
          height: 25,
          child: InfiniteCarousel.builder(
            velocityFactor: 1,
            itemCount: state.countries.length,
            itemExtent: context.mediaQuerySize.width * 0.3,
            onIndexChanged: (index) {
              print(index);
            },
            controller: scrollController,
            axisDirection: Axis.horizontal,
            loop: true,
            itemBuilder: (context, itemIndex, realIndex) => InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(left: AppConstants.p16),
                padding: const EdgeInsets.only(
                  left: AppConstants.p3,
                  top: AppConstants.p3,
                  bottom: AppConstants.p3,
                  right: AppConstants.p16,
                ),
                decoration: BoxDecoration(
                  color: context.theme.primaryColor,
                  borderRadius: BorderRadius.circular(
                    AppConstants.p12,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    final countryBloc = context.read<CountryCubit>();
                    final cityBloc = context.read<CitiesCubit>();
                    final chatsBloc = context.read<ChatsCubit>();
                    final pingBloc = context.read<PingCubit>();
                    final favouriteBloc = context.read<FavouriteCubit>();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: pingBloc),
                            BlocProvider.value(value: chatsBloc),
                            BlocProvider.value(value: cityBloc),
                            BlocProvider.value(value: countryBloc),
                            BlocProvider.value(value: favouriteBloc),
                          ],
                          child: const CountriesScreen(),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (state.countries[itemIndex].flag != null)
                        CachedNetworkImage(
                          alignment: Alignment.centerLeft,
                          imageUrl: state.countries[itemIndex].flag!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 19,
                            width: 19,
                            margin:
                                const EdgeInsets.only(right: AppConstants.p5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: imageProvider),
                            ),
                          ),
                        ),
                      Flexible(
                        child: FutureBuilder(
                            future: translate(
                                state.countries[itemIndex].countryName ?? ''),
                            builder: (context, text) {
                              if (!text.hasData) {
                                return const SizedBox();
                              }
                              return Text(
                                text.data ?? '',
                                style: context.theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
