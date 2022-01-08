import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:sizer/sizer.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({Key? key, required UserPaymentMethodModel cc})
      : _cc = cc,
        super(key: key);

  final UserPaymentMethodModel _cc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCreditCard(
                color: kGray,
                cardExpiration: _cc.exp,
                cardHolder: Get.find<StripeController>().userName,
                cardNumber: "XXXX XXXX XXXX ${_cc.last4}"),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  // Build the credit card widget
  Card _buildCreditCard(
      {@required Color? color,
      @required String? cardNumber,
      @required String? cardHolder,
      @required String? cardExpiration}) {
    const visaImagePath = 'assets/icons/payments/visa.svg';
    const masterCardImagePath = 'assets/icons/payments/mastercard.svg';
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 25.h,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(visaImagePath, masterCardImagePath),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  cardNumber!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'CourrierPrime'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder!,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock(String visa, String mastercard) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Container(),
        FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _cc.brand.isEmpty
                ? Container()
                : SvgPicture.asset(
                    _cc.brand == 'visa' ? visa : mastercard,
                    height: _cc.brand == 'visa' ? 3.h : 8.h,
                  ),
          ),
        )
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock(
      {@required String? label, @required String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '$label',
          style: const TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

// Build the FloatingActionButton
  // Container _buildAddCardButton({
  //   @required Icon? icon,
  //   @required Color? color,
  // }) {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 24.0),
  //     alignment: Alignment.center,
  //     child: FloatingActionButton(
  //       elevation: 2.0,
  //       onPressed: () {
  //         print("Add a credit card");
  //       },
  //       backgroundColor: color,
  //       mini: false,
  //       child: icon,
  //     ),
  //   );
  // }
}
