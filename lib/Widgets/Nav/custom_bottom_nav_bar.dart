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
        required double size,
        required double selectedSize,
        required String selectedIcon,
        required String label,
        required bool isSelected}) {
      return isSelected
          ? BottomNavigationBarItem(
              icon: SvgPicture.asset(
                selectedIcon,
                height: selectedSize.h,
              ),
              label: label,
            )
          : BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icon,
                height: size.h,
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
              size: 5,
              selectedSize: 5,
              icon: 'assets/icons/bottom_app_bar_icons/home.svg',
              label: 'Home',
              selectedIcon:
                  'assets/icons/bottom_app_bar_icons/training_active.svg',
              isSelected: 0 == _selectedIndex.value),
          getButton(
              size: 5,
              selectedSize: 6,
              icon: 'assets/icons/bottom_app_bar_icons/training.svg',
              label: 'Training',
              selectedIcon: 'assets/logo/mark.svg',
              isSelected: 1 == _selectedIndex.value),
          getButton(
              size: 5,
              selectedSize: 5,
              icon: 'assets/icons/bottom_app_bar_icons/history.svg',
              label: 'Schedule',
              selectedIcon:
                  'assets/icons/bottom_app_bar_icons/history_active.svg',
              isSelected: 2 == _selectedIndex.value),
          getButton(
              size: 5,
              selectedSize: 5,
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
