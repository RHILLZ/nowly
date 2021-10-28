import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider(
      {Key? key,
      required this.onChange,
      required FilterController filterController})
      : _filterController = filterController,
        super(key: key);

  final Function(double) onChange;
  final FilterController _filterController;
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
          overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12)),
      child: Obx(
        () => Slider(
          label: '${_filterController.radius} mi',
          activeColor: getWidgetSelectedColor(context),
          inactiveColor: Theme.of(context).disabledColor.withOpacity(0.1),
          value: _filterController.radius,
          min: 0,
          divisions: 20,
          max: 20,
          onChanged: (double value) {
            _filterController.radius = value;
            onChange(value);
          },
        ),
      ),
    );
  }
}
