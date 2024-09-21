import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/providers/locale_provider.dart';
import 'package:gw_chat/features/countries/view/countries_screen.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:provider/provider.dart';

class MediaRow extends StatefulWidget {
  const MediaRow({super.key, required this.media});

  final String media;

  @override
  State<MediaRow> createState() => _MediaRowState();
}

class _MediaRowState extends State<MediaRow> {
  bool isTicked = false;
  @override
  Widget build(BuildContext context) {
    // isTicked =
    //     context.read<FavouriteCubit>().checkContainsId(widget.city.cityId);
    return Container(
      height: AppConstants.p42,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.p12,
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            const SizedBox(width: AppConstants.p42),
            Expanded(
              child: Text(
                widget.media,
                // (Provider.of<LocaleProvider>(context).isRussian)
                //     ? widget.city.ruCityName ?? ''
                //     : widget.city.cityName ?? '',
                style: context.theme.textTheme.labelMedium,
              ),
            ),
            SvgPicture.asset(
              IconRoute.planet,
            ),
            const SizedBox(width: AppConstants.p12),
            InkWell(
              onTap: () async {
                // if (widget.countryModel.countryId != null) {
                //   setState(() => isTicked = !isTicked);
                //   await context.read<FavouriteCubit>().tickContains(
                //         widget.city.cityId!,
                //         widget.city.cityName,
                //         null,
                //         null,
                //         ClassType.city.name,
                //       );
                // }
              },
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
            const SizedBox(width: AppConstants.p42),
          ],
        ),
      ),
    );
  }
}
