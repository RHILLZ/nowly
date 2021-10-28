import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function(int) onTap;

  final _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarItem getButton(
        {required String icon,
        required String selectedIcon,
        required String label,
        required bool isSelected}) {
      return isSelected
          ? BottomNavigationBarItem(
              icon: SvgPicture.asset(
                selectedIcon,
                width: 4.w,
                height: 4.h,
              ),
              label: label,
            )
          : BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icon,
                // color: Theme.of(context)
                //     .bottomNavigationBarTheme
                //     .unselectedItemColor,
              ),
              label: label,
            );
    }

    return Obx(
      () => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          getButton(
              icon: 'assets/icons/bottom_app_bar_icons/home.svg',
              label: 'Home',
              selectedIcon: 'assets/icons/bottom_app_bar_icons/home_active.svg',
              isSelected: 0 == _selectedIndex.value),
          getButton(
              icon: 'assets/icons/bottom_app_bar_icons/training.svg',
              label: 'Training',
              selectedIcon:
                  'assets/icons/bottom_app_bar_icons/training_active.svg',
              isSelected: 1 == _selectedIndex.value),
          getButton(
              icon: 'assets/icons/bottom_app_bar_icons/schedule.svg',
              label: 'Schedule',
              selectedIcon:
                  'assets/icons/bottom_app_bar_icons/schedule_active.svg',
              isSelected: 2 == _selectedIndex.value),
          getButton(
              icon: 'assets/icons/bottom_app_bar_icons/profile.svg',
              label: 'Profile',
              selectedIcon:
                  'assets/icons/bottom_app_bar_icons/profile_active.svg',
              isSelected: 3 == _selectedIndex.value),
        ],
        currentIndex: 1,
        //selectedItemColor: Colors.amber[800],
        onTap: (index) {
          _selectedIndex.value = index;
          onTap(index);
        },
      ),
    );
  }
}
