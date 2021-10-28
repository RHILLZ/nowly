import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';

class BookedSessionDetails extends StatelessWidget {
  const BookedSessionDetails({Key? key, required this.details})
      : super(key: key);

  //final SessionCompleteController _controller = Get.find();
  final SessionReceiptModel details;

  Widget getStatus(String status) {
    Color color = kActiveColor;
    if (status == 'Canceled') {
      color = kerroreColor;
    } else if (status == 'Upcoming') {
      color = kPrimaryColor;
    }
    return Text(
      details.sessionStatus!,
      style: k16BoldTS.copyWith(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        // children: [
        //   if (details.amount !=
        //       null) // if showing in SCHEDULED APPOINTMENTS screen
        //     ListTile(
        //       title: const Text('AMOUNT'),
        //       trailing: Text(
        //         details.amount!,
        //         style: kRegularTS,
        //       ),
        //     ),
        //   ListTile(
        //     title: const Text('RECEIPT NUMBER'),
        //     trailing: Text(
        //       details.receiptNumber,
        //       style: kRegularTS,
        //     ),
        //   ),
        //   ListTile(
        //     title: const Text('DATE BOOKED'),
        //     trailing: Text(
        //       '${months[details.dateBooked.month - 1].toUpperCase()} ${details.dateBooked.day} ${details.dateBooked.year}',
        //       style: kRegularTS,
        //     ),
        //   ),
        //   ListTile(
        //     title: const Text('SESSION TIME'),
        //     trailing: Text(
        //       '${DateFormat.jm().format(details.startTime)} - ${DateFormat.jm().format(details.endTime)}',
        //       style: kRegularTS,
        //     ),
        //   ),
        //   ListTile(
        //     title: const Text('SESSION LENGTH'),
        //     trailing: Text(
        //       details.sessionlength!.length,
        //       style: kRegularTS,
        //     ),
        //   ),
        //   ListTile(
        //     title: const Text('PAYMENT METHOD'),
        //     trailing: Text(
        //       details.paymentMethod.method,
        //       style: kRegularTS,
        //     ),
        //   ),
        //   ListTile(
        //     title: const Text('STATUS'),
        //     trailing: getStatus(details.status),
        //   )
        // ],
        );
  }
}
