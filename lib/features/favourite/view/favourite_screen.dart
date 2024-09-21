import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/features/favourite/cubit/favourite_cubit.dart';
import 'package:gw_chat/features/root/view/widget/app_bar.dart';
import 'package:gw_chat/features/root/view/widget/side_bar.dart';
import 'package:gw_chat/generated/l10n.dart';
import 'widget/favourite_row.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    context.read<FavouriteCubit>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideBar(),
      appBar: rootAppBar(context),
      body: Container(
        color: context.theme.canvasColor,
        child: SingleChildScrollView(
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
                  S.of(context).bookmarks.replaceFirst(
                      S.of(context).bookmarks[0],
                      S.of(context).bookmarks[0].toUpperCase()),
                  style: context.theme.textTheme.titleSmall,
                ),
              ),
              const Divider(height: 0),
              BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => FavouriteRow(
                      favourite: state.data[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0),
                    itemCount: state.data.length,
                  );
                },
              ),
              const Divider(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
