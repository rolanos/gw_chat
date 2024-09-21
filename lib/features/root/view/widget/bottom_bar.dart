import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:gw_chat/features/favourite/view/favourite_screen.dart';
import 'package:gw_chat/features/social_media/view/social_media_sceen.dart';
import 'package:gw_chat/generated/l10n.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(AppConstants.p20)),
        color: context.theme.canvasColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: NavRow(
              path: IconRoute.markbook,
              text: S.of(context).bookmarks,
              onTap: () {
                final favourite = context.read<FavouriteCubit>();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: favourite,
                      child: const FavouriteScreen(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: NavRow(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SocialMediaScreen(),
                  ),
                );
              },
              path: IconRoute.chat,
              text: S.of(context).chat,
            ),
          ),
          Expanded(
            child: NavRow(
              path: IconRoute.meeting,
              text: S.of(context).meetings,
            ),
          ),
        ],
      ),
    );
  }
}

class NavRow extends StatelessWidget {
  const NavRow({super.key, required this.path, required this.text, this.onTap});

  final String path;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppConstants.p18,
            bottom: AppConstants.p16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                path,
                colorFilter: ColorFilter.mode(
                  context.theme.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: AppConstants.p12),
              Text(
                text,
                style: context.theme.textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
