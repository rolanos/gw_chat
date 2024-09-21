import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/theme.dart';
import 'package:gw_chat/features/main/view/cubit/statistic_cubit.dart';
import 'package:gw_chat/generated/l10n.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.canvasColor,
        borderRadius: BorderRadius.circular(
          AppConstants.p20,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: context.mediaQuerySize.height * 0.064,
          ),
          SvgPicture.asset(
            IconRoute.logo,
            width: context.mediaQuerySize.width * 0.4,
            colorFilter: ColorFilter.mode(
              context.theme.iconTheme.color ?? Colors.white,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: AppConstants.p12),
          Text(
            'GWChat',
            style: context.theme.textTheme.titleLarge,
          ),
          SizedBox(
            height: context.mediaQuerySize.height * 0.064,
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: BlocBuilder<StatisticCubit, StatisticState>(
                    builder: (context, state) {
                      return SphereWidget(
                        inLoading: state is StatisticLoading,
                        text: S.of(context).total_number_visitors,
                        value: state.totalUsers ?? 0,
                      );
                    },
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: BlocBuilder<StatisticCubit, StatisticState>(
                    builder: (context, state) {
                      return SphereWidget(
                        inLoading: state is StatisticLoading,
                        text: S.of(context).number_today_visitors,
                        value: state.totalUsersToday ?? 0,
                      );
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SphereWidget extends StatelessWidget {
  const SphereWidget({
    super.key,
    required this.text,
    required this.inLoading,
    required this.value,
  });

  final String text;

  final bool inLoading;

  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.p30,
            vertical: AppConstants.p30,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.gradient(context),
          ),
          child: inLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text(
                    value.toString(),
                    style: context.theme.textTheme.displayLarge,
                  ),
                ),
        ),
        const SizedBox(height: AppConstants.p16),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.p18,
            vertical: AppConstants.p7,
          ),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(
              AppConstants.p16,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
