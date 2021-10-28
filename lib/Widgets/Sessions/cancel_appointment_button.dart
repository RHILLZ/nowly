import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:sizer/sizer.dart';


class CancelAppointmentButton extends StatelessWidget {
  const CancelAppointmentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kCardCornerRadius),
              color: kLightGray),
          width: 30.w,
          height: 3.h,
          child: const Center(
            child: Text(
              'Contact',
              style: kRegularTS,
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
