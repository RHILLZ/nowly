import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';


class ModeSwitch extends StatelessWidget {
  ModeSwitch({Key? key, required this.onChange, required bool isDriving}) :  super(key: key){
    this.isDriving.value = isDriving;
  }
  final double _width = 200;

  final isDriving = true.obs;
  final Function(TravelMode mode) onChange;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.all(20),
      width: _width,
      height: 50,
      decoration: BoxDecoration(
          color: getWidgetSelectedColor(context),
          borderRadius: BorderRadius.circular(100)),
      child: Stack(
        children: [
          Obx(
            () => Positioned(
              top: 0,
              bottom: 0,
              right: isDriving.value ? null : 0,
              left: isDriving.value ? 0 : null,
              child: Container(
                margin: const EdgeInsets.all(2),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(' '),
                width: _width / 2,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(_width / 2)),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      isDriving.value = true;
                      onChange(TravelMode.driving);
                    },
                    child: Container(
                        margin: const EdgeInsets.all(2),
                        width: _width / 2,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Obx(
                          () => Text(
                            'I’M DRIVING',
                            style: TextStyle(
                                color: isDriving.value
                                    ? null
                                    : getSelectedTxtColor(context)),
                          ),
                        )),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      onChange(TravelMode.walking);
                      isDriving.value = false;
                    },
                    child: Container(
                        margin: const EdgeInsets.all(2),
                        width: _width / 2,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Obx(
                          () => Text(
                            'I’M WALKING',
                            style: TextStyle(
                                color: isDriving.value
                                    ? getSelectedTxtColor(context)
                                    : null),
                          ),
                        )),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
