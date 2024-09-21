import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/model/favourite_model.dart';
import 'package:gw_chat/core/providers/locale_provider.dart';
import 'package:gw_chat/core/repository/shared_prefs_repository.dart';
import 'package:gw_chat/core/translator.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:provider/provider.dart';

class FavouriteRow extends StatefulWidget {
  const FavouriteRow({
    super.key,
    required this.favourite,
  });

  final FavouriteModel favourite;

  @override
  State<FavouriteRow> createState() => _FavouriteRowState();
}

class _FavouriteRowState extends State<FavouriteRow> {
  @override
  Widget build(BuildContext context) {
    Provider.of<LocaleProvider>(context);
    return Container(
      height: AppConstants.p42,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.p12,
      ),
      child: InkWell(
        onTap: () async {},
        child: Row(
          children: [
            const SizedBox(width: AppConstants.p42),
            Expanded(
              flex: 3,
              child: FutureBuilder(
                  future: translate(widget.favourite.name ?? ''),
                  builder: (context, text) {
                    if (!text.hasData) {
                      return const SizedBox();
                    }
                    return Text(
                      text.data ?? '-',
                      style: context.theme.textTheme.labelMedium,
                    );
                  }),
            ),
            SvgPicture.asset(
              IconRoute.planet,
            ),
            const SizedBox(width: AppConstants.p12),
            InkWell(
              onTap: () async {
                context.read<FavouriteCubit>().tickContains(
                      widget.favourite.id,
                      widget.favourite.name,
                      widget.favourite.wikiUrl,
                      widget.favourite.flagUrl,
                      widget.favourite.classType?.name,
                    );
              },
              child: SvgPicture.asset(IconRoute.favourite,
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(118, 225, 118, 1),
                    BlendMode.srcIn,
                  )),
            ),
            const SizedBox(width: AppConstants.p42),
          ],
        ),
      ),
    );
  }
}
