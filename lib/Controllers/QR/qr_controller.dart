import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRController extends GetxController {
  QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void scaningData(Barcode data) {
    AppLogger.i(data.code);
  }

  void onPermissionSet(
      BuildContext context, QRViewController ctrl, bool p) async {
    AppLogger.w('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      AppPermissionController appPermissionController = Get.find();
      await appPermissionController.requestCameraPermission();
    }
  }
}
