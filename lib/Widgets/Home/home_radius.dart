import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:sizer/sizer.dart';

import '../widget_exporter.dart';

class HomeRadius extends StatelessWidget {
  const HomeRadius({Key? key, required FilterController controller})
      : _controller = controller,
        super(key: key);

  final FilterController _controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Within ${_controller.radius} mile radius',
              style: k10BoldTS.copyWith(fontSize: 12),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomSlider(
                onChange: (v) => _controller.radius = v,
                filterController: _controller)
          ],
        ));
  }
}
