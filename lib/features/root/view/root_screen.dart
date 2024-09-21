import 'package:flutter/material.dart';
import 'package:gw_chat/features/main/view/main_screen.dart';
import 'widget/app_bar.dart';
import 'widget/bottom_bar.dart';
import 'widget/side_bar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      endDrawer: const SideBar(),
      appBar: rootAppBar(context),
      bottomNavigationBar: const BottomBar(),
      body: MainScreen(),
    );
  }
}
