import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:sizer/sizer.dart';

class UserPaymentMethodsList extends StatelessWidget {
  UserPaymentMethodsList({Key? key}) : super(key: key);
  final StripeController _stripeController = Get.find<StripeController>();

  noPaymentMethods() => const ListTile(
        title: Text('No Cards On File'),
        trailing: Icon(Icons.money_off),
      );
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        itemCount: _stripeController.paymentMethods.length,
        itemBuilder: (ctx, i) =>
            buildPaymentMethod(context, _stripeController.paymentMethods[i])));
  }

  final visaImagePath = 'assets/icons/payments/visa.svg';
  final masterCardImagePath = 'assets/icons/payments/mastercard.svg';

  buildPaymentMethod(BuildContext context, UserPaymentMethodModel pm) =>
      ListTile(
          onTap: () {
            _stripeController.activePaymentMethod = pm;
            _stripeController.setActivePaymentId(pm.id);
          },
          onLongPress: () => _stripeController.activePaymentMethod.id == pm.id
              ? _stripeController.selectOtherCardWarning()
              : _stripeController.deletePaymentMethodDialog(context, pm.id),
          leading: FittedBox(
              fit: BoxFit.contain,
              child: SvgPicture.asset(
                pm.brand == 'visa' ? visaImagePath : masterCardImagePath,
                height: pm.brand == 'visa' ? 2.h : 5.h,
              )),
          title: Text('XXXX XXXX XXXX ${pm.last4}'),
          trailing: Icon(Icons.check_circle_outline,
              color: _stripeController.activePaymentMethod.exp == pm.exp
                  ? Colors.green
                  : kGray));
}
