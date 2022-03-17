import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Screens/Nav/home_view.dart';
import 'package:nowly/Screens/Nav/session_history_view.dart';
import 'package:nowly/Screens/Account/user_account_screen.dart';
import 'package:nowly/Utils/app_logger.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);
  // ignore: unused_field

  final _selectedIndex = 1.obs;
  static const routeName = '/baseScreen';

  final screens = [
    // MapScreen(),
    SessionHistoryView(),
    UserHomeView(),
    const UserAccountScreen()
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
          AppLogger.info('Screen ${_selectedIndex.value}');
          return screens[_selectedIndex.value];
        },
      ),
    );
  }
}
