import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/model/city.dart';
import 'package:gw_chat/core/model/country.dart';
import 'package:gw_chat/core/model/favourite_model.dart';
import 'package:gw_chat/core/providers/locale_provider.dart';
import 'package:gw_chat/core/translator.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:provider/provider.dart';

class CityRow extends StatefulWidget {
  const CityRow({super.key, required this.city, required this.countryModel});

  final City city;
  final Country countryModel;

  @override
  State<CityRow> createState() => _CityRowState();
}

class _CityRowState extends State<CityRow> {
  bool isTicked = false;

  @override
  Widget build(BuildContext context) {
    isTicked =
        context.read<FavouriteCubit>().checkContainsId(widget.city.cityId);
    return SizedBox(
      height: AppConstants.p42,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              const SizedBox(width: AppConstants.p42),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p12,
                  ),
                  child: Text(
                    (Provider.of<LocaleProvider>(context).isRussian)
                        ? widget.city.ruCityName ?? ''
                        : widget.city.cityName ?? '',
                    style: context.theme.textTheme.labelMedium,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
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
                          widget.city.cityId!,
                          widget.city.cityName,
                          null,
                          null,
                          ClassType.city.name,
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
