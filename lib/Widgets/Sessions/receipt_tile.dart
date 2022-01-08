import 'package:flutter/material.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';

class ReceiptListTile extends StatelessWidget {
  const ReceiptListTile({Key? key, required SessionReceiptModel receipt})
      : _receipt = receipt,
        super(key: key);

  final SessionReceiptModel _receipt;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileImage(
        imageURL: _receipt.trainerProfilePicURL,
        rad: 2.5,
      ),
      title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '${_receipt.sessionWorkoutType} Session',
          )),
      subtitle: Text(_receipt.trainerName!),
      trailing: Text('${_receipt.sessionCharged}'),
    );
  }
}
