import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Screens/Map/map_screen.dart';
import 'package:nowly/Screens/Nav/home_view.dart';
import 'package:nowly/Screens/Nav/session_history_view.dart';
import 'package:nowly/Screens/Profile/user_profile_screen.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);
  // ignore: unused_field

  final _selectedIndex = 0.obs;
  static const routeName = '/baseScreen';

  final screens = [
    UserHomeView(),
    MapScreen(),
    SessionHistoryAndUpcomingView(),
    const UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        onTap: (index) {
          _selectedIndex.value = index;
        },
      ),
      body: Obx(
        () {
          AppLogger.i('Screen ${_selectedIndex.value}');
          return screens[_selectedIndex.value];
        },
      ),
    );
  }
}
