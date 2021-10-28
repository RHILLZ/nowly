import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Screens/Map/filters.dart';

import '../widget_exporter.dart';

class SessionFilterButton extends StatelessWidget {
  const SessionFilterButton({
    Key? key,
    this.enableShadow = true,
  }) : super(key: key);

  final bool enableShadow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: double.maxFinite,
      child: RoundedCornerButton(
          enableShadows: enableShadow,
          color: Theme.of(context).cardColor,
          radius: 50,
          onTap: () {
            Get.bottomSheet(
              SafeArea(
                  child: SizedBox(
                      height: Get.height - kToolbarHeight,
                      child: Material(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Filters()))),
              ignoreSafeArea: false,
              isScrollControlled: true,
            );
          },
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/images/map/filter.svg',
                color: Theme.of(context).iconTheme.color,
              ))),
    );
  }
}
