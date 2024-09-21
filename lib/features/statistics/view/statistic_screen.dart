import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/features/countries/cubit/country_cubit.dart';
import 'package:gw_chat/features/statistics/cubit/graph_statistic_cubit.dart';
import 'package:gw_chat/features/statistics/view/widget/chart.dart';

import 'package:gw_chat/generated/l10n.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppConstants.p20,
        right: AppConstants.p20,
      ),
      decoration: BoxDecoration(
        color: context.theme.canvasColor,
        borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(AppConstants.p20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: AppConstants.p20,
              top: AppConstants.p25,
            ),
            child: Text(
              S.of(context).statistics,
              style: context.theme.textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: AppConstants.p42),
          Expanded(
            child: BlocBuilder<GraphStatisticCubit, GraphStatisticState>(
              builder: (context, state) {
                return LineChartCustom(
                  userList: state.people,
                  rightTitle: S.of(context).people,
                );
              },
            ),
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          BlocBuilder<CountryCubit, CountryState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await context
                          .read<GraphStatisticCubit>()
                          .pastCountry(state.countries);
                    },
                    icon: SvgPicture.asset(IconRoute.arrowLeft),
                  ),
                  BlocBuilder<GraphStatisticCubit, GraphStatisticState>(
                    builder: (context, state) {
                      if (state.country?.flag != null) {
                        return CachedNetworkImage(
                          alignment: Alignment.centerLeft,
                          imageUrl: state.country!.flag!,
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
                        );
                      }

                      return Text(
                        state.country?.countryName ?? 'Пусто',
                        style: context.theme.textTheme.labelMedium,
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () async {
                      await context
                          .read<GraphStatisticCubit>()
                          .nextCountry(state.countries);
                    },
                    icon: SvgPicture.asset(IconRoute.arrowRight),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          Expanded(
            child: BlocBuilder<GraphStatisticCubit, GraphStatisticState>(
              builder: (context, state) {
                return LineChartCustom(
                  userList: state.countries,
                  rightTitle: S.of(context).countries,
                );
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
