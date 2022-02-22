import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class Filters extends StatelessWidget {
  Filters({
    Key? key,
  }) : super(key: key);
  final FilterController _controller = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Material(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: 70,
                      height: 8,
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).disabledColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  primary: false,
                  padding: UIParameters.screenPadding,
                  child: Column(
                    children: [
                      const Text('Radius for In Person Sessions',
                          style: k16BoldTS),
                      Text('${_controller.radius} miles'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 4),
                        child: CustomSlider(
                          filterController: _controller,
                          onChange: (double i) {
                            _controller.radius = i;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: const [
                            Text('0 mi.', style: kRegularTS),
                            Spacer(),
                            Text('20 mi.', style: kRegularTS)
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Text('SORT AND FILTER', style: k16BoldTS),
                      ),
                      const TrainerPreference(),
                      // SessionMode(),
                      // const Avalability(),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
