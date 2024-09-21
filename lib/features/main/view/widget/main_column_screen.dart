import 'package:flutter/material.dart';
import 'package:gw_chat/core/constants.dart';
import 'package:gw_chat/features/main/view/widget/countries_container.dart';

import 'info_container.dart';

class MainColumnScreen extends StatefulWidget {
  const MainColumnScreen({super.key});

  @override
  State<MainColumnScreen> createState() => _MainColumnScreenState();
}

class _MainColumnScreenState extends State<MainColumnScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CountriesContainer(),
        SizedBox(height: AppConstants.p10),
        Expanded(child: InfoContainer()),
        SizedBox(height: AppConstants.p10),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
