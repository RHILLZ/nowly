import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';


class StringValueSlider extends StatelessWidget {
  const StringValueSlider(
      {Key? key,
      required this.currentSliderValue,
      required this.values,
      required this.onChange})
      : super(key: key);

  final RxInt currentSliderValue;
  final List<String> values;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Slider(
            activeColor: getWidgetSelectedColor(context),
            inactiveColor: Theme.of(context).cardColor,
            value: currentSliderValue.value.toDouble(),
            min: 0,
            max: values.length.toDouble() - 1,
            divisions: values.length - 1,
            label: values[currentSliderValue.value],
            onChanged: (double value) {
              currentSliderValue.value = value.toInt();
            },
          ),
          Text(values[currentSliderValue.value])
        ],
      ),
    );
  }
}
