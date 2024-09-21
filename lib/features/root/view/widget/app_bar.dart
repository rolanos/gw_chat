import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/generated/l10n.dart';

AppBar rootAppBar(BuildContext context) {
  return AppBar(
    leadingWidth: 0,
    leading: const SizedBox(),
    actions: [
      Builder(builder: (context) {
        return InkWell(
          onTap: () => Scaffold.of(context).openEndDrawer(),
          child: Padding(
            padding: const EdgeInsets.only(right: AppConstants.p12),
            child: SvgPicture.asset(
              IconRoute.sideBar,
            ),
          ),
        );
      }),
    ],
    title: Row(
      children: [
        SvgPicture.asset(
          IconRoute.logo,
        ),
        const SizedBox(width: AppConstants.mediumPadding),
        Text(
          S.of(context).appBarText,
          style: context.theme.textTheme.titleMedium,
        ),
        const Spacer(),
      ],
    ),
  );
}
