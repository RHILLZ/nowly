import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ReceiptDetailsScreen extends GetView {
  ReceiptDetailsScreen({Key? key, required SessionReceiptModel receipt})
      : _receipt = receipt,
        super(key: key);
  static const routeName = '/appoinmnetDetailsScreen';

  var month = {
    1: 'JAN',
    2: 'FEB',
    3: 'MAR',
    4: 'APR',
    5: 'MAY',
    6: 'JUN',
    7: 'JUL',
    8: 'AUG',
    9: 'SEP',
    10: 'OCT',
    11: 'NOV',
    12: 'DEC',
  };
  final SessionReceiptModel _receipt;
  @override
  Widget build(BuildContext context) {
    Timestamp time = _receipt.sessionTimestamp!;
    final mo = month[time.toDate().month];
    final day = '${time.toDate().day}TH';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${_receipt.sessionMode} Session'.toUpperCase()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                    foregroundImage: _receipt.userProfilePicURL != null
                        ? NetworkImage(_receipt.userProfilePicURL!)
                        : null,
                    child: _receipt.userProfilePicURL != null
                        ? null
                        : SvgPicture.asset('assets/icons/logo.svg'),
                    radius: 8.h),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _receipt.userName!,
                style: k20BoldTS,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '$mo $day'.toUpperCase(),
                  style: k20RegularTS,
                ),
              ),
              Text(
                _receipt.sessionCharged! + '0',
                style: k20BoldTS,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              ReceiptDetailInfo(
                receipt: _receipt,
              ),
              // if (appoinment.status == 'Upcoming')
              //   Padding(
              //     padding: UIParameters.screenPadding,
              //     child: RectButton(
              //       onPressed: () {},
              //       title: 'RESCHEDULE',
              //       isSelected: true,
              //     ),
              //   ),
              // if (appoinment.status == 'Completed')
              //   Padding(
              //     padding: UIParameters.screenPadding,
              //     child: MainButton(
              //       onTap: () {},
              //       title: 'BOOK AGAIN',
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
