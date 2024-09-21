import 'package:flutter/material.dart';
import 'package:gw_chat/features/main/view/widget/main_column_screen.dart';
import 'package:gw_chat/features/statistics/view/statistic_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: const [
        MainColumnScreen(),
        StatisticScreen(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
