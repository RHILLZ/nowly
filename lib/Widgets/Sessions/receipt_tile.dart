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
        imageURL: _receipt.userProfilePicURL,
        rad: 2.5,
      ),
      title: Text(
          '${_receipt.sessionDuration} ${_receipt.sessionWorkoutType} session'),
      subtitle: Text(_receipt.userName!),
      trailing: Text('${_receipt.sessionCharged}'),
    );
  }
}
