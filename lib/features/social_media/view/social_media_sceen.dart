import 'package:flutter/material.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/features/root/view/widget/app_bar.dart';
import 'package:gw_chat/features/root/view/widget/side_bar.dart';
import 'package:gw_chat/features/social_media/view/widget/media_row.dart';
import 'package:gw_chat/generated/l10n.dart';

class SocialMediaScreen extends StatelessWidget {
  SocialMediaScreen({super.key});

  final list = [
    "Telegram",
    "Facebook",
    "VK",
    "X",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideBar(),
      appBar: rootAppBar(context),
      body: Container(
        color: context.theme.canvasColor,
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
                S.of(context).media,
                style: context.theme.textTheme.titleSmall,
              ),
            ),
            const Divider(height: 0),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => MediaRow(
                media: list[index],
              ),
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemCount: list.length,
            ),
            const Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
