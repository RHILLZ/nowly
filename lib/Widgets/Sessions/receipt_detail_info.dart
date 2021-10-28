import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';

class ReceiptDetailInfo extends StatelessWidget {
  const ReceiptDetailInfo({Key? key, required SessionReceiptModel receipt})
      : _receipt = receipt,
        super(key: key);

  final SessionReceiptModel _receipt;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ListTile(
        //   title: Text('amount'.toUpperCase()),
        //   trailing: Text(
        //     _receipt.sessionCharged!,
        //     style: kRegularTS,
        //   ),
        // ),
        ListTile(
          title: Text('receipt number'.toUpperCase()),
          trailing: Text(
            _receipt.sessionID!,
            style: kRegularTS,
          ),
        ),
        ListTile(
          title: Text('Session Timestamp'.toUpperCase()),
          trailing: Text(
            DateTime.fromMicrosecondsSinceEpoch(
                    _receipt.sessionTimestamp!.microsecondsSinceEpoch)
                .toLocal()
                .toString()
                .substring(0, 19),
            style: kRegularTS,
          ),
        ),
        ListTile(
          title: Text('session workout type'.toUpperCase()),
          trailing: Text(
            _receipt.sessionWorkoutType!,
            style: kRegularTS,
          ),
        ),
        ListTile(
          title: Text('session length'.toUpperCase()),
          trailing: Text(
            _receipt.sessionDuration!,
            style: kRegularTS,
          ),
        ),
        // ListTile(
        //   title: Text('payment method'.toUpperCase()),
        //   trailing: Text(
        //     _receipt.paymentMethod!,
        //     style: kRegularTS,
        //   ),
        // ),
        ListTile(
          title: Text('status'.toUpperCase()),
          trailing: Text(
            _receipt.sessionStatus!,
            style: kRegularTS.copyWith(color: kActiveColor),
          ),
        )
      ],
    );
  }
}
