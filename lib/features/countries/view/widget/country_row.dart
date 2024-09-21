import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/model/country.dart';
import 'package:gw_chat/core/model/favourite_model.dart';
import 'package:gw_chat/core/providers/locale_provider.dart';
import 'package:gw_chat/features/cities/view/cities_screen.dart';
import 'package:gw_chat/features/cities/view/cubit/cities_cubit.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:gw_chat/features/main/view/cubit/ping_cubit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryRow extends StatefulWidget {
  const CountryRow({super.key, required this.countryModel});

  final Country countryModel;

  @override
  State<CountryRow> createState() => _CountryRowState();
}

class _CountryRowState extends State<CountryRow> {
  bool isTicked = false;
  @override
  Widget build(BuildContext context) {
    isTicked = context
        .read<FavouriteCubit>()
        .checkContainsId(widget.countryModel.countryId);
    return SizedBox(
      height: AppConstants.p42,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () async {
            final citiesCubit = context.read<CitiesCubit>();
            final favouriteCubit = context.read<FavouriteCubit>();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: citiesCubit),
                  BlocProvider.value(value: favouriteCubit),
                ],
                child: CitiesScreen(
                  countryModel: widget.countryModel,
                ),
              ),
            ));
            await citiesCubit.getCities(
                countyId: widget.countryModel.countryId);
            await context
                .read<PingCubit>()
                .callPing(countryId: widget.countryModel.countryId);
          },
          child: Row(
            children: [
              const SizedBox(width: AppConstants.p42),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p12,
                  ),
                  child: Text(
                    widget.countryModel.countryName ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelMedium,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.p16),
              if (widget.countryModel.flag != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p12,
                  ),
                  child: CachedNetworkImage(
                    alignment: Alignment.centerLeft,
                    imageUrl: widget.countryModel.flag!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 19,
                      width: 19,
                      margin: const EdgeInsets.only(right: AppConstants.p5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: AppConstants.p16),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p12,
                  ),
                  child: Text(
                    (Provider.of<LocaleProvider>(context).isRussian)
                        ? widget.countryModel.ruCountryName ?? ''
                        : widget.countryModel.countryName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.labelMedium,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.p10),
              InkWell(
                onTap: () async {
                  if (widget.countryModel.wiki == null) {
                    return;
                  }
                  final url = Uri.parse(widget.countryModel.wiki!);
                  if (!(await launchUrl(url))) {
                    log('Could not launch $url');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p12,
                    horizontal: AppConstants.p7,
                  ),
                  child: SvgPicture.asset(
                    IconRoute.planet,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (widget.countryModel.countryId != null) {
                    setState(() => isTicked = !isTicked);
                    await context.read<FavouriteCubit>().tickContains(
                          widget.countryModel.countryId!,
                          widget.countryModel.countryName,
                          widget.countryModel.wiki,
                          widget.countryModel.flag,
                          ClassType.country.name,
                        );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p12,
                    horizontal: AppConstants.p7,
                  ),
                  child: SvgPicture.asset(
                    IconRoute.favourite,
                    colorFilter: isTicked
                        ? const ColorFilter.mode(
                            Color.fromRGBO(118, 225, 118, 1),
                            BlendMode.srcIn,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.p30),
            ],
          ),
        ),
      ),
    );
  }
}
