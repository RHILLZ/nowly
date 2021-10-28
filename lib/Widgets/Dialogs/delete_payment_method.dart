import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Constants/constants.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:sizer/sizer.dart';

class RemovePaymentMethodDialog extends StatelessWidget {
  const RemovePaymentMethodDialog({Key? key, required String pmID})
      : _pmID = pmID,
        super(key: key);

  final String _pmID;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kActiveButtonColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: 28.h,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LOGOWTEXT,
              SizedBox(
                height: 1.h,
              ),
              const Text('Delete Payment Method?', style: k16BoldTS),
              Expanded(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                      onPressed: () => Get.find<StripeController>()
                          .removePaymentMethod(_pmID),
                      child: const Text('Delete')),
                  TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Nevermind')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
